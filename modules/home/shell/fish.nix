{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      cat = "bat";
      du = "dust";
      ps = "procs";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
    plugins = [
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
    ];
    functions = {
      fish_greeting = ''
        test "$TERM" = foot; and return

        set -l cache_dir $XDG_CACHE_HOME
        set -l cache_file $XDG_CACHE_HOME/shell_greeting.json

        if not test -d $cache_dir
            mkdir -p $cache_dir 2>/dev/null
        end

        if test -f $cache_file
            set -l data (cat $cache_file | jq -r '.hitokoto, .from' 2>/dev/null)

            if test -z "$data"
                fish -c "curl -s 'https://v1.hitokoto.cn/' > $cache_file 2>/dev/null" &
                return
            end

            set -l content $data[1]
            set -l author "<$data[2]>"
            set -l content_display_length (echo -n $content | wc -L)
            set -l author_display_length (echo -n "$author" | wc -L)
            set -l box_width (math "max($content_display_length, $author_display_length) + 2")
            set -l border (string repeat -n $box_width "═")

            echo " ╔$border╗"

            if test $content_display_length -gt $author_display_length
                set -l author_padding (string repeat -n (math $box_width - $author_display_length -2) " ")
                echo " ║ $content ║"
                echo " ║$author_padding $author ║"
            else
                set -l content_padding (string repeat -n (math $box_width - $content_display_length -2) " ")
                echo " ║ $content $content_padding║"
                echo " ║ $author ║"
            end

            echo " ╚$border╝"
        end

        fish -c "curl -s 'https://v1.hitokoto.cn/' > $cache_file 2>/dev/null" &
      '';
    };
  };

  # Setting fish as your login shell may cause issues because fish is not POSIX compliant.
  # Here is one solution, keeping bash as the system shell but having it exec fish when run interactively.
  # which launches fish unless the parent process is already fish.
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
