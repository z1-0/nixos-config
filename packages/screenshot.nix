{
  writeShellApplication,
  grim,
  slurp,
  wl-clipboard,
  libnotify,
  coreutils,
  ...
}:

writeShellApplication {
  name = "screenshot";
  runtimeInputs = [
    grim
    slurp
    wl-clipboard
    libnotify
    coreutils
  ];

  meta.description = "Screenshot tool with fullscreen (default) and region selection (-r) support";

  text = ''
    set -euo pipefail  # Enable strict error handling

    # Default configuration
    PICTURES_DIR="''${XDG_PICTURES_DIR:-$HOME/Pictures}"
    FILENAME_PREFIX="screenshot"
    NOTIFY_TIMEOUT=3000
    REGION_MODE=false

    # Display help information
    show_help() {
      echo "Usage: $0 [OPTIONS]"
      echo "OPTIONS:"
      echo "  -r, --region    - Region selection mode"
      echo "  -h, --help      - Show this help message"
      echo ""
      echo "Screenshots are copied to clipboard and saved to: $PICTURES_DIR"
    }

    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -r|--region)
          REGION_MODE=true
          shift
          ;;
        -h|--help)
          show_help
          exit 0
          ;;
        *)
          echo "Error: Unknown argument '$1'" >&2
          echo "Use '$0 --help' for usage information" >&2
          exit 1
          ;;
      esac
    done

    # Set mode text
    if [[ "$REGION_MODE" == "true" ]]; then
      MODE_TEXT="Region Screenshot"
    else
      MODE_TEXT="Fullscreen Screenshot"
    fi

    # Create save directory if it doesn't exist
    mkdir -p "$PICTURES_DIR" || {
      echo "Error: Cannot create directory '$PICTURES_DIR'" >&2
      exit 1
    }

    # Generate unique filename
    TIMESTAMP=$(${coreutils}/bin/date +%Y%m%d_%H%M%S)
    FILENAME="$PICTURES_DIR/''${FILENAME_PREFIX}_''${TIMESTAMP}.png"

    # Screenshot function
    take_screenshot() {
      if [[ "$REGION_MODE" == "true" ]]; then
        echo "Select region to screenshot..."
        ${grim}/bin/grim -g "$(${slurp}/bin/slurp)" - | \
          ${coreutils}/bin/tee "$FILENAME" | \
          ${wl-clipboard}/bin/wl-copy
      else
        ${grim}/bin/grim - | \
          ${coreutils}/bin/tee "$FILENAME" | \
          ${wl-clipboard}/bin/wl-copy
      fi
    }

    # Error handling function
    handle_error() {
      local exit_code=$?
      local error_msg=""

      case $exit_code in
        130) error_msg="Operation cancelled by user" ;;  # Ctrl+C
        1)   error_msg="Screenshot command failed" ;;
        *)   error_msg="Unknown error (exit code: $exit_code)" ;;
      esac

      ${libnotify}/bin/notify-send -u critical -t "$NOTIFY_TIMEOUT" "Screenshot Failed" "$error_msg"
      exit $exit_code
    }

    # Set error handling trap
    trap handle_error ERR INT TERM

    # Execute screenshot
    if take_screenshot; then
      # Verify file was created successfully
      if [[ -f "$FILENAME" ]]; then
        FILE_SIZE=$(${coreutils}/bin/du -h "$FILENAME" | ${coreutils}/bin/cut -f1)
        ${libnotify}/bin/notify-send -t "$NOTIFY_TIMEOUT" \
          "''${MODE_TEXT} Saved" \
          "File: $(basename "$FILENAME")\nSize: $FILE_SIZE\nDirectory: $PICTURES_DIR"
      else
        ${libnotify}/bin/notify-send -u critical -t "$NOTIFY_TIMEOUT" "Screenshot Failed" "Screenshot file was not created"
        exit 1
      fi
    else
      # Error handling is done by the trap, no need for additional handling here
      exit 1
    fi
  '';
}
