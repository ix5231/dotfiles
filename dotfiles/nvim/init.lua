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
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require("gruvbox").setup({ contrast = "soft" })
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable('gdscript')
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter'.setup {
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
  {
    'vlime/vlime',
    ft = 'lisp'
  },
  'equalsraf/neovim-gui-shim',
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup() 
      require('mini.surround').setup() 
      require('mini.bracketed').setup() 
      require('mini.files').setup() 
      vim.api.nvim_create_user_command(
        'File',
        function(opts)
          MiniFiles.open()
        end,
        {}
      )
    end
  },
  {
    'LintaoAmons/cd-project.nvim',
    config = function()
      require("cd-project").setup({
        projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/cd-project.nvim.json"),
        project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
        vim.api.nvim_create_user_command(
          'Proj',
          function(opts)
            vim.fn['fzf#run'](vim.fn['fzf#wrap']({
              source = require('cd-project.api').get_project_names(),
              sink = 'cd'
            }))
          end,
          {}
        )
      })
    end
  }
})

vim.cmd('colorscheme gruvbox')
vim.o.termguicolors = true
vim.o.number = true
vim.o.cursorline = true

if vim.fn.has('win32') == 1 then
  vim.opt.shell = 'pwsh.exe'
  vim.env.MYINIT = '$LOCALAPPDATA/nvim/init.lua'
end

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.keymap.set('i', 'fd', '<ESC>')

vim.filetype.add({
  extension = {
    fnl = 'lisp',
  }
})

