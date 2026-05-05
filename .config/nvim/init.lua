-- Entry point for the Neovim configuration.
-- Loads core options, keymaps and autocommands, then bootstraps lazy.nvim.

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
