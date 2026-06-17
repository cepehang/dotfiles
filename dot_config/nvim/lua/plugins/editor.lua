return {
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin-frappe" } },

  { -- keymap discovery
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      spec = {
        {
          mode = { "n", "v" },
          { "gx", desc = "Exchange operator" },
          { "<leader>f", desc = "file" },
          { "<leader>o", desc = "obsidian notes" },
        },
      },
    },
  },

  { -- picker & file side-explorer
    "folke/snacks.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume last" },
      { "grr", function() Snacks.picker.lsp_references() end, desc = "LSP references" },
      { "gr", false } -- use default neovim gr mapping
    },
    opts = {
      animate = { step = 10 }, -- ms per set
      indent = { animate = { step = 10 } }, -- ms per set
      explorer = { replace_netrw = false }, -- yazi is used instead
      picker = {
        win = {
          input = {
            keys = {
              -- ["<c-p>"] = { "history_back", mode = { "i", "n" } },
              -- ["<c-n>"] = { "history_forward", mode = { "i", "n" } },
              -- qwerty-fr remapping
              ["é"] = { "cycle_win", mode = { "n" } },
            },
          },
          list = { keys = { ["<"] = "cycle_win", mode = { "n" } } },
          preview = { keys = { ["<"] = "cycle_win", mode = { "n" } } },
        },
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = {
            hidden = true,
            layout = { layout = { position = "right" } },
            win = {
              input = {
                keys = {
                  ["<c-p>"] = { "history_back", mode = { "i", "n" } },
                  ["<c-n>"] = { "history_forward", mode = { "i", "n" } },
                },
              },
            },
          },
        },
      },
      terminal = {
        auto_insert = false,
        win = {
          -- position = "float",
          keys = {
            -- nav_h = false,
            -- nav_j = false,
            -- nav_k = false,
            -- nav_l = false,
            term_normal = {
              "<esc>",
              function(self)
                self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                if self.esc_timer:is_active() then
                  self.esc_timer:stop()
                  vim.cmd("stopinsert")
                else
                  self.esc_timer:start(400, 0, function() end) -- double default timer
                  return "<esc>"
                end
              end,
              mode = "t",
              expr = true,
              desc = "Double escape to normal mode",
            },
          },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          Snacks.toggle.zoom():map("<c-w>m")
        end,
      })
    end,
  },

  { -- file manager integration
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>-", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
      { "<leader>_", mode = { "n", "v" }, "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
    },
    opts = {
      open_for_directories = true,
      integrations = {
        grep_in_directory = "snacks.picker",
        grep_in_selected_files = "snacks.picker",
      },
      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-s>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-g>",
        replace_in_directory = "<c-r>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = "<c-\\>",
        open_and_pick_window = "<c-o>",
      },
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  { -- autocompletion
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<cr>"] = {},
        ["<c-k>"] = { "select_prev", "fallback" },
        ["<c-j>"] = { "select_next", "fallback" },
      },
    },
  },

  { -- todo highlighting
    "folke/todo-comments.nvim",
    opts = { highlight = { comments_only = false } }, -- allow todo highlighting in markdown files
  },

  { -- additional vim operators
    "nvim-mini/mini.operators",
    opts = { replace = { prefix = "gR" }, exchange = { prefix = "gX" } },
  },

  { -- search and replace
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sR",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
      { "<leader>sr", false },
    },
  },

  -- { -- tmux integration
  --   "christoomey/vim-tmux-navigator",
  --   cmd = {
  --     "TmuxNavigateLeft",
  --     "TmuxNavigateDown",
  --     "TmuxNavigateUp",
  --     "TmuxNavigateRight",
  --     "TmuxNavigatePrevious",
  --     "TmuxNavigatorProcessList",
  --   },
  --   keys = {
  --     { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  --     { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  --     { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  --     { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  --     { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  --   },
  -- },
}
