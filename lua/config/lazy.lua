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
        { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
        {
            'projekt0n/github-nvim-theme',
		    config = function()
		        vim.cmd('colorscheme github_dark_high_contrast')
		    end
        },
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	    {
		    'VonHeikemen/lsp-zero.nvim',
		    branch = 'v2.x',
		    dependencies = {
		    	{'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim', build = ':MasonUpdate'},
                {'williamboman/mason-lspconfig.nvim'},
		        {'hrsh7th/nvim-cmp'},
		        {'hrsh7th/cmp-nvim-lsp'},
		        {'L3MON4D3/LuaSnip'},
            }
	    },
        { 'tpope/vim-fugitive' },
        { 'github/copilot.vim' },
        { 'akinsho/git-conflict.nvim', version = "*", config = true }
    },
    checker = { enabled = true },
})
