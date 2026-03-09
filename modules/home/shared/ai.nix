{ flake, ... }:
{
  imports = [ flake.self.lib.modules.claude-code-router ];

  programs.claude-code-router = {
    enable = true;
    service.enable = true;
    claude-code.enable = true;
  };
}
