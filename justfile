set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

build:
    nix build .#neovim-tools

run *args: build
    nix shell .#neovim-tools nixpkgs#neovim -c nvim -u ./src/init.lua {{args}}

nvim *args: run
    @:

nvim-clean *args: build
    XDG_CONFIG_HOME=/tmp/nvim-test-config \
    XDG_DATA_HOME=/tmp/nvim-test-data \
    XDG_STATE_HOME=/tmp/nvim-test-state \
    nix shell .#neovim-tools nixpkgs#neovim -c nvim -u ./src/init.lua {{args}}
