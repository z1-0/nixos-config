default:
    @just --list

activate:
    nix run --show-trace

fmt:
    treefmt

update:
    nix flake update
