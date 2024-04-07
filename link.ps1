function Link-Dot {
  param ([string]$from, [string]$to)

  if (Test-Path $to -PathType Leaf) {
    Write-Output "ファイルが存在するためスキップ: $to"
    return
  }

  $dir = Sprit-Path -Parent $from

  New-Item -ItemType Directory -ErrorAction SilentlyContinue -Path $dir
  New-Item -ItemType SymbolicLink -Path $from -Value $to
}

Link-Dot $env:localappdata/nvim/init.lua $PSScriptRoot/dotfiles/nvim/init.lua

Link-Dot $env:userprofile/.editorconfig $PSScriptRoot/dotfiles/editorconfig
