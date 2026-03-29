# Dotfiles

Configs are managed by symlinking — only link what you need for a given device.

## Symlink

Unix:
```sh
ln -s <source> <destination>
```

PowerShell:
```powershell
New-Item -ItemType SymbolicLink -Path <destination> -Target <source>
```

## Configs

| Config | Destination |
|--------|-------------|
| wezterm | `~/.config/wezterm` |
| neovim (nvch) | `~/.config/nvch` (unix) / `~/AppData/Local/nvch` (windows) |
| neovim (nvim) | `~/.config/nvim` (unix) / `~/AppData/Local/nvim` (windows) |
| fish | `~/.config/fish/config.fish` |
| bash | `~/.bash_profile` |
| ghostty | `~/.config/ghostty/config` |
| starship | `~/.config/starship.toml` |
| aerospace | `~/.aerospace.toml` (mac only) |
| glazewm | `~/.glzr` |
| ohmyposh | `~/neeon.omp.json` |
| powershell | `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` |
| idea | `~/.ideavimrc` |
| visualstudio | `~/.vsvimrc` |
| kanata | create a shortcut with `-c <config>` and `-q` for quiet mode |

