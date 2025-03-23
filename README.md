
# Dotfiles

unix-shell

```bash
mkdir -p ~/project/personal/
cd ~/project/peronsl/
git clone git@github.com:teoshibin/all_dotfiles.git

```

powershell

```pwsh
New-Item -ItemType Directory -Path $env:USERPROFILE/project/personal -Force
cd ~/project/peronsl/
git clone git@github.com:teoshibin/all_dotfiles.git
```

## Windows

- glazewm `~/`
- idea `-`
- pwsh `~/Documents/PowerShell/`
- wezterm `~/.config/`
- nvchad `~/AppData/Local/`
- ohmyposh `~/`

```pwsh
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.config\wezterm" -Target "$env:USERPROFILE\project\personal\all_dotfiles\wezterm"

```

## Mac

- idea `-`
- wezterm `~/.config/`
- nvchad `~/.config/`
- fish `~/.config/`

```bash
ln -s ~/.config/wezterm ~/project/personal/wezterm
```

## Linux

- wezterm `~/.config/`
- nvchad `~/.config/`
- fish `~/.config/`


```bash
ln -s ~/.config/wezterm ~/project/personal/wezterm
```
