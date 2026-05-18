return {
  { -- formatter
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },

  { -- language server protocol
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gr", false },
            {
              "grn", -- default neovim mapping
              function()
                local inc_rename = require("inc_rename")
                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
              end,
              expr = true,
              desc = "Rename (inc-rename.nvim)",
              has = "rename",
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                autopep8 = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                pylsp_mypy = { enabled = true, exclude = { "tests/*" } }, -- installed using :PylspInstall pylsp-mypy
                yapf = { enabled = false },
              },
            },
          },
          -- enabled = false,
        },
        ty = { enabled = true },
        copilot = { enabled = false },
      },
    },
  },

  { -- debugger
    "rcarriga/nvim-dap-ui",
    -- stylua: ignore
    keys = {
      { "<leader>ds", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dr", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dR", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    },
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "watches", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
          },
          position = "right",
          size = 50,
        },
        {
          elements = {
            { id = "repl", size = 1 },
            -- { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
      mappings = {
        edit = "i",
        expand = { "<CR>", "<2-LeftMouse>", "<tab>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
    },
  },

  { -- tests
    "nvim-neotest/neotest",
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
      { "<leader>tr", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    },
  },

  { -- LLM integration
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false },
    },
  },
}
