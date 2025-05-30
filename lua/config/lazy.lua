local ensure_lazy = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/lazy/start/lazy.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print("installing lazy")
    fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", install_path })
    vim.cmd [[packadd lazy.nvim]]
    return true
  end
  return false
end

ensure_lazy()

return require("lazy").setup({
    spec = {
        {
            'nvim-telescope/telescope.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            'projekt0n/github-nvim-theme',
		    config = function()
		        vim.cmd('colorscheme github_dark_high_contrast')
		    end
        },
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
        {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        { 'tpope/vim-fugitive' },
        { 'tpope/vim-surround' },
        { 'github/copilot.vim' },
        {
            'akinsho/git-conflict.nvim',
            version = "*",
            config = true
        },
        {
            'stevearc/oil.nvim',
            opts = {
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                },
            }
        },
    },
    checker = { enabled = true },
})
