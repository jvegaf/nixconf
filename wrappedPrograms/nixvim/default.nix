{ inputs, ... }:
{
  flake.wrappers.nixvim =
    { wlib, config, ... }:
    {

      imports = [
        inputs.nixvim.nixosModules.nixvim

        wlib.modules.default
      ];

      nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };

      programs.nixvim = {
        imports = [
          ./_keymaps.nix
          ./_lsp.nix
          ./plugins/_actions-preview.nix
          ./plugins/_barbar.nix
          ./plugins/_blink-cmp.nix
          ./plugins/_comment.nix
          ./plugins/_conform.nix
          ./plugins/_dial.nix
          ./plugins/_dropbar.nix
          ./plugins/_flash.nix
          ./plugins/_flash.nix
          ./plugins/_harpoon.nix
          ./plugins/_inc-rename.nix
          ./plugins/_neo-tree.nix
          ./plugins/_neogit.nix
          ./plugins/_numb.nix
          ./plugins/_sidekick.nix
          ./plugins/_snacks.nix
          ./plugins/_treesitter.nix
          ./plugins/_treesj.nix
          ./plugins/_trouble.nix
          ./plugins/_whichkey.nix
          ./plugins/_yanky.nix
          ./_extra_plugins.nix
        ];

        enable = true;

        enableMan = false;

        withRuby = false;

        # colorscheme = "ayu-dark";
        colorschemes = {
          catppuccin = {
            enable = true;
            settings.flavour = "frappe";
            settings.default_integrations = true;
          };
        };

        performance = {
          byteCompileLua = {
            enable = true;
            luaLib = true;
            nvimRuntime = true;
            plugins = true;
          };
        };

        globals = {
          mapleader = " ";
          maplocalleader = ",";
          timeoutlen = 500;
        };

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
          foldlevel = 99;
          foldlevelstart = 99;
          list = true;
          updatetime = 2000;
          termguicolors = true;
        };

        clipboard = {
          register = "unnamedplus";
          providers = {
            wl-copy.enable = true;
            xsel.enable = true;
            xclip.enable = true;
          };
        };

        plugins = {
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
          lualine = {
            enable = true;
            settings = {
              globalstatus = true;
              # theme = "ayu-dark";
            };
          };
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
              add = "gaa";
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
      };
    };
}
