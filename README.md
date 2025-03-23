
# Dotfiles

I don't see a point automating them, I want to keep it simple, symlink it when I need it.

Unix-shell

```bash
mkdir -p ~/project/personal/
cd ~/project/peronsl/
git clone git@github.com:teoshibin/all_dotfiles.git
```

Powershell

```pwsh
New-Item -ItemType Directory -Path $env:USERPROFILE/project/personal -Force
cd ~/project/peronsl/
git clone git@github.com:teoshibin/all_dotfiles.git
```

## Windows

- glazewm `~/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.glzr" -Target "$env:USERPROFILE\project\personal\all_dotfiles\glazewm\.glzr"
```

- powershell `~/Documents/PowerShell/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$env:USERPROFILE\project\personal\all_dotfiles\powershell\Microsoft.PowerShell_profile.ps1"
```

- wezterm `~/.config/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.config\wezterm" -Target "$env:USERPROFILE\project\personal\all_dotfiles\wezterm"
```

- [nvchad](/neovim/nvch/) `~/AppData/Local/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvch" -Target "$env:USERPROFILE\project\personal\all_dotfiles\neovim\nvch"
```

- ohmyposh `~/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\neeon.omp.json" -Target "$env:USERPROFILE\project\personal\all_dotfiles\ohmyposh\neeon.omp.json"
```

- idea `-`

## Mac

- wezterm `~/.config/`

```bash
ln -s ~/.config/wezterm ~/project/personal/wezterm
```

- [nvchad](/neovim/nvch/) `~/.config/`

```bash
ln -s ~/.config/nvch ~/project/personal/neovim/nvch
```

- fish `~/.config/`
- idea `-`

## Linux

- wezterm `~/.config/`

```bash
ln -s ~/.config/wezterm ~/project/personal/wezterm
```

- [nvchad](/neovim/nvch/) `~/.config/`

```bash
ln -s ~/.config/nvch ~/project/personal/neovim/nvch
```

- fish `~/.config/`
