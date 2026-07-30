_:
{ lib, config, ... }:
let
  files = [
    ".agents/AGENTS.md"
    ".claude/CLAUDE.md"
    ".codex/AGENTS.md"
    ".config/opencode/AGENTS.md"
    ".gemini/GEMINI.md"
  ];
in
{
  options.prompts = {
    source = lib.mkOption {
      type = lib.types.path;
      description = "Path to the AGENTS.md file to symlink";
    };
  };

  config.home.file = lib.listToAttrs (
    map (filePath: {
      name = filePath;
      value.source = config.prompts.source;
    }) files
  );
}
