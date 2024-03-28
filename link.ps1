New-Item -ItemType Directory -Force -Path $env:localappdata/nvim
New-Item -ItemType SymbolicLink -Path $env:localappdata/nvim/init.lua -Value $PSScriptRoot/dotfiles/nvim/init.lua
