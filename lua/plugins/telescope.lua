return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  defaults = {
    winblend = 0,
    file_ignore_patterns = {
      ".git/",
      ".cache",
      "%.o",
      "%.a",
      "%.out",
      "%.class",
      "%.pdf",
      "%.mkv",
      "%.mp4",
      "%.zip",
      "target/",
    },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
}
