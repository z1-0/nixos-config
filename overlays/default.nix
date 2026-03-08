{ flake, ... }:
let
  inherit (flake) inputs;
in
final: prev: {
  # nixpkgs-stable = import inputs.nixpkgs-stable { inherit (prev) system config; };
  # vscode-extensions = inputs.vscode-extensions.overlays.default final prev;

  nur = import inputs.nur {
    nurpkgs = prev;
    pkgs = prev;
  };

  inherit (inputs.llm-agents.overlays.default final prev) llm-agents;
}
