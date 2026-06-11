# TokenUse Homebrew Tap

## Install

```bash
brew tap tokenuse/tap
brew install tokenuse
```

## Upgrade

```bash
brew upgrade tokenuse
```

## Uninstall

```bash
tokenuse uninstall
brew uninstall tokenuse
brew untap tokenuse/tap
```

`tokenuse uninstall` stops and removes the background tracker before Homebrew removes the package. It also asks whether to delete local TokenUse data such as config, credentials, queued events, prompts, cursors, cache, and logs.

If the `tokenuse` binary is already gone, remove these paths manually:

- `~/Library/LaunchAgents/ai.tokenuse.tracker.plist` on macOS
- `~/.config/systemd/user/tokenuse-tracker.service` on Linux
- `~/.local/share/tokenuse/bin/tokenuse`
- `~/.config/tokenuse/`
- `~/.local/share/tokenuse/`
- `~/.cache/tokenuse/`

## Links

- [Website](https://tokenuse.ai)
- [Documentation](https://github.com/tokenuse/tokenuse-cli#readme)
