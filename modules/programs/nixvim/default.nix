{
  delib,
  inputs,
  lib,
  pkgs,
  ...
}:
delib.module {
  # code editor
  name = "programs.nixvim";

  options = delib.singleEnableOption true;

  home.always.imports = [ inputs.nixvim.homeModules.nixvim ];

  home.ifEnabled = {
    home = {
      sessionVariables = {
        # nvim as the default editor
        EDITOR = "nvim";
        # nvim as the default editor
        VISUAL = "nvim";
      };
    };

    programs.nixvim = {
      enable = true;

      # # recognise slim-rails files
      # # https://github.com/slim-template/slim-rails/blob/a6ae6b27d625b3703d9447cb5737b7007ce7874e/lib/slim-rails/register_engine.rb#L34
      # autoCmd = [
      #   {
      #     event = ["BufRead" "BufNewFile"];
      #     pattern = "*.slim";
      #     command = "set filetype=slim";
      #   }
      # ];

      globals = {
        mapleader = " ";
        maplocalleader = ",";
        timeoutlen = 500;
      };

      # vanilla keymaps
      keymaps = [
        {
          key = "<c-left>";
          action = "<C-w>h";
        }
        {
          key = "<c-down>";
          action = "<C-w>j";
        }
        {
          key = "<c-up>";
          action = "<C-w>k";
        }
        {
          key = "<c-right>";
          action = "<C-w>l";
        }
        {
          key = "<leader>fc";
          action = "<cmd>let @+ = expand('%:.')<cr>";
          options = {
            desc = "copy the relative path to clipboard";
          };
        }
        {
          key = "<leader>W";
          action = "<cmd>wa<cr>";
          options = {
            desc = "save all files";
          };
        }
        {
          key = "<leader>q";
          action = "<cmd>qa!<cr>";
          options = {
            desc = "exit immediately";
          };
        }
      ];

      # use the root flake's nixpkgs instead of nixvim's pinned one
      nixpkgs.source = inputs.nixpkgs;

      # base options
      opts = {
        expandtab = true;
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 4;
        cursorline = true;
        scrolloff = 5;
        visualbell = true;
        ignorecase = true;
        smartcase = true;
        hlsearch = true;
        undofile = true;
        spell = false;
        foldenable = true;
        foldlevel = 99;
        foldlevelstart = 99;
        list = true;
        updatetime = 2000;
        termguicolors = true;
        swapfile = false;
      };

      plugins = {
        # lazy loading
        lz-n.enable = true;
        better-escape = {
          enable = true;
        };
        diffview = {
          enable = true;
          settings = {
            enhanced_diff_hl = true;
          };
        };
        fidget.enable = true;
        lastplace.enable = true;
        grug-far.enable = true;
        luasnip.enable = true;
        nix.enable = true;
        nix-develop.enable = true;
        markview.enable = true;
        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true;
          };
        };
        mini-surround = {
          enable = true;
          settings.mappings = {
            add = "gsa";
            delete = "gsd";
            find = "gsf";
            find_left = "gsF";
            replate = "gsr";
            update_n_lines = "gsn";
          };
        };
        tmux-navigator.enable = true;
        lazygit.enable = true;
        nvim-ufo.enable = true;
        web-devicons.enable = true;
        smear-cursor.enable = true;
      };

      withNodeJs = false;
      withPerl = false;
      withRuby = false;

      # nixos-unstable vs nixvim main drift around branch-off; silence the warning
      version.enableNixpkgsReleaseCheck = false;

      clipboard = {
        register = "unnamedplus";
        providers = {
          wl-copy.enable = true;
          xsel.enable = true;
          xclip.enable = true;
        };
      };
    };

    home = {
      shellAliases = {
        v = "nvim";
      };
    };

    xdg = lib.mkIf (pkgs.stdenv.hostPlatform.isLinux) {
      # add launcher for neovim
      desktopEntries.nvim = {
        categories = [
          "Utility"
          "TextEditor"
        ];
        exec = "kitty -e nvim";
        genericName = "Text Editor";
        icon = "nvim";
        name = "Neovim";
      };
    };
  };
}
