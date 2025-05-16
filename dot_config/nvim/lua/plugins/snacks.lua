return {
  {
    "folke/snacks.nvim",
    opts = {
      animate = {
        duration = 5, -- ms per step
        easing = "linear",
        fps = 60,
      },
    },
    config = function()
      -- Toggle the profiler
      Snacks.toggle.profiler():map("<leader>pp")
      -- Toggle the profiler highlights
      Snacks.toggle.profiler_highlights():map("<leader>ph")
    end,
    keys = {
      {
        "<leader>ps",
        function()
          Snacks.profiler.scratch()
        end,
        desc = "Profiler Scratch Buffer",
      },
    },
  },

  -- Optional lualine component to show captured events
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, Snacks.profiler.status())
    end,
  },
}
