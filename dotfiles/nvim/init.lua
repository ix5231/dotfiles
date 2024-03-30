local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'ellisonleao/gruvbox.nvim',
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require'lspconfig'.gdscript.setup{}
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
      }
    end
  }
})

vim.cmd('colorscheme gruvbox')
vim.o.termguicolors = true
vim.o.number = true
vim.o.cursorline = true

vim.keymap.set('i', 'fd', '<ESC>')
