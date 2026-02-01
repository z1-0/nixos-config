set allow-duplicate-recipes := true

# List all available recipes
default:
    @just --list

# Validate flake configuration without building
check:
    nix flake check --no-build

# Format all files
fmt:
    nix fmt

# Build configuration for testing without activation
b:
    sudo nixos-rebuild build --flake .

# Activate configuration for current hostname
s:
    sudo nixos-rebuild switch --flake .

# Activate with full trace for debugging
sv:
    sudo nixos-rebuild switch --flake . --show-trace --verbose

# Preview changes: show diff between current and new system
diff:
    sudo nixos-rebuild build --flake . && nix store diff-closures /run/current-system ./result

# Emergency rollback to previous generation
r:
    sudo nixos-rebuild switch --rollback

# Update all flake inputs to latest versions
up:
    nix flake update

# Remove system generations older than 7 days
clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

# Garbage collect unused paths and delete old generations
gc:
    sudo nix-collect-garbage --delete-old
    sudo nix store gc --debug

# Launch interactive Nix REPL with nixpkgs
repl:
    nix repl -f flake:nixpkgs
