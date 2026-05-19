# Project: Chezmoi Dotfiles

Multi-machine dotfiles managed with chezmoi.

## Target Machines

| Host | OS | DE/WM | Status |
|------|-----|-------|--------|
| Home laptop | Arch Linux | KDE Plasma (moving to Hyprland) | Active |
| Work laptop | macOS | - | Active |

## Chezmoi Patterns

- **Templated files**: `.tmpl` extension, use Go template syntax (`{{ .chezmoi.os }}`, `{{ .osid }}`)
- **Private files**: `private_` prefix applies 0o600 permissions
- **Dot prefix**: `dot_` becomes `.` in target path
- **OS-specific data**: `.chezmoi.os` ("linux"/"darwin"), custom `osid` ("linux-arch"/"darwin")

## Scripts

- `run_once_*`: Execute once per machine
- `run_onchange_*`: Execute when content changes
- Use `.tmpl` suffix for OS-conditional scripts

## Key Locations

- `private_dot_config/`: XDG config dir (ghostty, kitty, nvim)
- `dot_pi/agent/AGENTS.md`: Agent instructions (this file sources from there)
- `.chezmoi.toml.tmpl`: Config template prompting for username/email/ssh_passphrase

## Conventions

- Prefer templating over duplication for OS differences
- Use chezmoi externals (`.chezmoiexternal.toml`) for external resources
- Package installs via `run_onchange_before_*` scripts per-OS

## Common Operations

```bash
# Apply changes from repo to home directory
chezmoi apply

# Add a new file to management
chezmoi add ~/.config/somefile

# Edit a managed file (opens in $EDITOR, applies on save if configured)
chezmoi edit ~/.zshrc

# See what would change before applying
chezmoi diff

# Pull latest from remote and apply
chezmoi update

# Re-initialize (useful after adding new template vars)
chezmoi init --apply

# Check for unmanaged files in ~/.config
chezmoi unmanaged | grep -v '^Library' | head -20
```
