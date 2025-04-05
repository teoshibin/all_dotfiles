
# Dotfiles

## Unix

```sh
ln -s <source> <destination>
```

## Powershell

```powershell
New-Item -ItemType SymbolicLink -Path <destination> -Target <source> 
```

## dotfiles

- glazewm `~/.gzlr`
- ohmyposh `~/neeon.omp.json`
- powershell `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1`
- kanata & kanata-gui

Create a shortcut with flag `-c` for config path and `-q` for quiet no logging.

```txt
"<kanata-gui>" -q -c "<config>"
```

- [neovim nvch](/neovim/nvch/)
    - windows `~/AppData/Local/`
    - unix `~/.config/nvch`
- idea `~/.ideavimrc`
- wezterm `~/.config/wezterm`

- fish `~/.config/fish/config.fish`
- bash `~/.bash_profile`
- ghostty `~/.config/ghostty/config`

