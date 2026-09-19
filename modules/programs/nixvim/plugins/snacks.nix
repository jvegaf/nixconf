{ delib, pkgs, ... }:
delib.module {
  # collection of plugins
  name = "programs.nixvim.plugins.snacks";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          snacks = true;
        };
      };
    };

    extraPackages = [
      # Snacks.image
      pkgs.imagemagick
      pkgs.ghostscript
    ];

    extraLuaPackages = luaPkgs: [
      luaPkgs.sqlite
    ];

    keymaps = [
      {
        key = "<leader>cu";
        action = "<cmd>lua Snacks.picker.lsp_references()<cr>";
        options = {
          desc = "show lsp references";
        };
      }
      {
        key = "<leader>fo";
        action = "<cmd>lua Snacks.picker.recent()<cr>";
        options = {
          desc = "find last edited files";
        };
      }
      {
        key = "<leader>fr";
        action = "<cmd>lua Snacks.picker.resume()<cr>";
        options = {
          desc = "resume last search";
        };
      }
      {
        key = "<leader>fs";
        action = "<cmd>lua Snacks.picker.grep({hidden=true})<cr>";
        options = {
          desc = "search project";
        };
      }
      {
        key = "<leader>fw";
        action = "<cmd>lua Snacks.picker.grep_word({hidden=true})<cr>";
        options = {
          desc = "search project for current word";
        };
      }
      {
        key = "<leader>t";
        action = "<cmd>lua Snacks.picker.files({hidden=true})<cr>";
        options = {
          desc = "find files";
        };
      }
      {
        key = "<leader><space>";
        action = "<cmd>lua Snacks.picker.files({hidden=true})<cr>";
        options = {
          desc = "find files";
        };
      }
    ];

    plugins.snacks = {
      enable = true;

      settings = {
        bigfile.enabled = true;
        explorer = {
          enabled = false;
        };
        input = {
          enabled = true;
          prompt_pos = "float";
        };
        indent = {
          enabled = true;
          chunk = {
            enabled = true;
            char.arrow = "󰁔";
          };
        };
        notifier = {
          enabled = true;
          style = "fancy";
        };
        picker = {
          enabled = true;
          win = {
            input = {
              keys.__raw = ''
                {
                  ["<a-s>"] = { "flash", mode = { "n", "i" } },
                  ["s"] = { "flash" },
                }
              '';
            };
          };
          actions.__raw = ''
            {
              flash = function(picker)
                require("flash").jump({
                  pattern = "^",
                  label = { after = { 0, 0 } },
                  search = {
                    mode = "search",
                    exclude = {
                      function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                      end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                })
              end,
            }
          '';
        };
        scope.enabled = true;
        scroll = {
          enabled = true;
        };
        statuscolumn = {
          enabled = true;
          left = [
            "mark"
            "sign"
          ];
          right = [
            "fold"
            "git"
          ];
          folds = {
            open = false;
            git_hl = false;
          };
          git = {
            patterns = [
              "GitSign"
              "MiniDiffSign"
            ];
          };
          refresh = 50;
        };
        terminal = {
          enabled = true;
        };
        toggle = {
          enabled = true;
        };
        words = {
          enabled = true;
          debounce = 100;
        };
        quickfile.enabled = true;
        styles = {
          notification = {
            wp.wrap = true;
          };
        };
      };

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
