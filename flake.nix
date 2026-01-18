{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixos-unified.url = "github:srid/nixos-unified";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    llm-agents.url = "github:numtide/llm-agents.nix";
    ghostty.url = "github:ghostty-org/ghostty";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    devenv.url = "github:cachix/devenv";
    ah.url = "github:0x7a696f6e/ah.sh";
    ah.inputs.devenv.follows = "devenv";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
    betterfox.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, ... }:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
}
