{ self, ... }: {
  flake.nixosModules.general =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.extra_hjem
        self.nixosModules.gtk
        self.nixosModules.nix
      ];

      users.mutableUsers = true;

      users.users.${config.preferences.user.name} = {
        isNormalUser = true;
        description = "${config.preferences.user.name}'s account";
        extraGroups = [
          "wheel"
          "networkmanager"
          "video"
          "audio"
        ];
        shell = self.packages.${pkgs.stdenv.hostPlatform.system}.environment;

        hashedPasswordFile = "/persist/passwd";
        initialPassword = "nixos";
      };

      persistance.data.directories = [
        "nixconf"

        "Videos"
        "Downloads"
        "Documents"
        "Code"
        "Music"
        "Desktop"

        ".ssh"
        ".local/share/keyrings"

        ".config/vjenv"
        ".local/state/vjenv"
        ".local/share/vjenv"

        # ".local/share/claude-per"
        # ".local/share/claude-fish"
        ".local/share/opencode"
      ];

      persistance.cache.directories = [
        # ".config/Bitwarden CLI"

        ".local/share/zoxide"
        ".local/share/nvim"
        ".local/share/fish"
        ".local/share/zsh"
        ".config/nvim"
      ];
    };
}
