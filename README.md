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

| Config | Source | Destination |
|--------|--------|-------------|
| wezterm | `wezterm/` | `~/.config/wezterm` |
| neovim (nvch) | `neovim/nvch/` | `~/.config/nvch` (unix) / `~/AppData/Local/nvch` (windows) |
| neovim (nvim) | `neovim/nvim/` | `~/.config/nvim` (unix) / `~/AppData/Local/nvim` (windows) |
| fish | `fish/mac_config.fish` or `fish/wsl_config.fish` | `~/.config/fish/config.fish` |
| bash | `bash/.bash_profile` | `~/.bash_profile` |
| ghostty | `ghostty/config` | `~/.config/ghostty/config` |
| starship | `starship/starship.toml` | `~/.config/starship.toml` |
| aerospace | `aerospace/aerospace.toml` | `~/.aerospace.toml` (mac only) |
| glazewm | `glazewm/` | `~/.glzr` |
| ohmyposh | `ohmyposh/neeon.omp.json` | `~/neeon.omp.json` |
| powershell | `powershell/Microsoft.PowerShell_profile.ps1` | `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` |
| idea | `idea/.mac_ideavimrc` or `idea/.win_ideavimrc` | `~/.ideavimrc` |
| visualstudio | `visualstudio/.vsvimrc` | `~/.vsvimrc` |
| kanata | `kanata/` | create a shortcut with `-c <config>` and `-q` for quiet mode |

