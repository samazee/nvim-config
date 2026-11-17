-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc><Cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>nh", "<Esc><Cmd>noh<CR>", { desc = "No highlight" })

require("lazy").setup({
  spec = {
        {
            'nvim-telescope/telescope.nvim',
			tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
                vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
                vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
                vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            end
        },
        {
            'nvim-treesitter/nvim-treesitter',
			branch = "master",
--			tag = "0.10.0",
            build = ":TSUpdate",
            config = function () 
                local configs = require("nvim-treesitter.configs")
                configs.setup({
                    auto_install = true,
                    highlight = { enable = true },
                    indent = { enable = true },  
                })
            end
        },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000
        },
		{
			"42paris/42header"
		},
        {
            "Diogo-ss/42-C-Formatter.nvim",
            cmd = "CFormat42",
            config = function()
                local formatter = require "42-formatter"
                formatter.setup({
                    formatter = 'c_formatter_42',
                    filetypes = { c = true, h = true, cpp = true, hpp = true },
                })
            end
        },
		{
			"neovim/nvim-lspconfig"
		},
		{
			"mason-org/mason.nvim",
			opts = {}
		},
		{
			"L3MON4D3/LuaSnip",
			version = "v2.5.0",
			build = "make install_jsregexp"
		}
    },
    checker = { enabled = true },
})

vim.cmd("colorscheme catppuccin")
