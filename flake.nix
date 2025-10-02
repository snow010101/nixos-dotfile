{
  description = "Снежный NixOS"; # Например, "My NixOS Configuration"

  inputs = {
    zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    # to have it up-to-date or simply don't specify the nixpkgs input
    inputs.nixpkgs.follows = "nixpkgs";
  };
  # Укажите здесь желаемый канал nixpkgs.
    # Замените "nixos-23.11" на вашу версию из system.stateVersion в configuration.nix
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Замените "my-nixos" на hostname вашей машины
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Для ARM-систем укажите "aarch64-linux"
      modules = [
        ({ config, pkgs, ... }: {
	fonts.packages = with pkgs; [
 	  nerd-fonts.fira-code
	  nerd-fonts.iosevka
 	  nerd-fonts.droid-sans-mono
	 ];
	  fonts.fontconfig.enable = true;
          programs.steam.enable = true;
          programs.fish.enable = true;
          programs.niri.enable = true;
          programs.kdeconnect.enable = true;
          environment.systemPackages = with pkgs; [
            neovim
	    swww
	    obs-studio
	    waybar
	    rofi
            kitty
            font-awesome
            inputs.zen-browser.packages."${system}".default
            fastfetch
            htop
            vim
            gimp
            git
            wget
            localsend
          ];
        })
        ./configuration.nix # Импортируем существующий файл конфигурации
        ./hardware-configuration.nix
      ];
    };
  };
}
