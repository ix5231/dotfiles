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
  },
  'junegunn/fzf',
  {
    'junegunn/fzf.vim',
    config = function()
      vim.keymap.set('n', '<C-P>', function()
        vim.cmd('FZF')
      end)
    end
  },
})

vim.cmd('colorscheme gruvbox')
vim.o.termguicolors = true
vim.o.number = true
vim.o.cursorline = true
if vim.fn.has('win32') then
  vim.opt.shell = 'pwsh.exe'
end


vim.keymap.set('i', 'fd', '<ESC>')
