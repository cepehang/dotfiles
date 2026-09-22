return {
  { -- markdown rendering in neovim
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "◯" },
        checked = { icon = "✔" },
        custom = { todo = { rendered = "" } },
      },
    },
  },

  { -- obsidian integration
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim", "saghen/blink.cmp", "folke/snacks.nvim" },
    ft = "markdown",
    keys = {
      { "<leader>so", "<cmd>ObsidianQuickSwitch<cr>", desc = "Search Obsidian vault" },
      { "<leader>oo", "<cmd>ObsidianToday<cr>", desc = "Open today's note" },
    },
    opts = {
      workspaces = { { name = "Noise", path = "~/org/noise" } },
      ui = { enable = false },
      link = { auto_update = true },
    },
  },
}
