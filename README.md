
# Dotfiles

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
- idea `-`
- powershell `~/Documents/PowerShell/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "C:\Users\teosh\project\personal\all_dotfiles\powershell\Microsoft.PowerShell_profile.ps1"

```
- wezterm `~/.config/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.config\wezterm" -Target "$env:USERPROFILE\project\personal\all_dotfiles\wezterm"
```

- nvchad `~/AppData/Local/`
- ohmyposh `~/`

## Mac

- idea `-`
- wezterm `~/.config/`

```bash
ln -s ~/.config/wezterm ~/project/personal/wezterm
```

- nvchad `~/.config/`
- fish `~/.config/`

## Linux

- wezterm `~/.config/`

```bash
ln -s ~/.config/wezterm ~/project/personal/wezterm
```

- nvchad `~/.config/`
- fish `~/.config/`
