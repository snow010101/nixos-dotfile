{
  description = "Снежный NixOS";

  inputs = {
    zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    # to have it up-to-date or simply don't specify the nixpkgs input
    inputs.nixpkgs.follows = "nixpkgs";
  };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # "nixos" на хостнейм вашей машины, узнать можно через команду hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; 
      modules = [
        ({ config, pkgs, ... }: {
          programs.steam.enable = true;
          programs.fish.enable = true;
          environment.systemPackages = with pkgs; [
            neovim
            fastfetch
            htop
            vim
            git
            wget
          ];
        })
        ./configuration.nix 
        ./hardware-configuration.nix
      ];
    };
  };
}
