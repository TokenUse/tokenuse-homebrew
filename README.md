# TokenUse Homebrew Tap

![TokenUse brand banner](https://assets.tokenuse.ai/branding/readme-banner-v2.png)

[![npm version](https://img.shields.io/npm/v/tokenuse?label=npm)](https://www.npmjs.com/package/tokenuse)
[![Homebrew tap version](https://img.shields.io/github/v/release/tokenuse/tokenuse?label=homebrew&color=fbb040&logo=homebrew&logoColor=white)](https://github.com/tokenuse/tokenuse-homebrew/blob/main/Formula/tokenuse.rb)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
![Platform: macOS and Linux](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-24292f)

Track and analyze Claude Code and OpenAI Codex usage and costs with TokenUse.

![TokenUse dashboard preview](https://assets.tokenuse.ai/branding/readme-dashboard-v1.png)

## Install

```bash
brew tap tokenuse/tap
brew install tokenuse
```

Homebrew 6.0 and later require third-party taps to be trusted before their
formulae will load. If you see `Refusing to load formula tokenuse/tap/tokenuse
from untrusted tap`, run `brew trust tokenuse/tap` and install again.

## Upgrade

```bash
brew upgrade tokenuse
```

### If `brew update` reports an error in this tap

On 2026-08-06 this repository's history was rewritten and force-pushed. `brew update`
updates a tap by rebasing your local copy onto the remote, and a rebase onto unrelated
history cannot resolve itself — it stops partway and leaves conflict markers in
`Formula/tokenuse.rb`, after which the formula no longer parses and every `brew`
command touching the tap fails.

Re-tapping is the reliable fix. It does not touch the installed binary or your
TokenUse data:

```bash
brew untap tokenuse/tap
brew tap tokenuse/tap
```

To repair the existing checkout in place instead:

```bash
cd "$(brew --repository)/Library/Taps/tokenuse/homebrew-tap"
git rebase --abort 2>/dev/null
git reset --hard origin/main
git clean -fd
```

This is a one-time fix. A fresh `brew tap tokenuse/tap` is unaffected.

## Uninstall

```bash
tokenuse uninstall
brew uninstall tokenuse
brew untap tokenuse/tap
```

`tokenuse uninstall` stops and removes the background tracker before Homebrew removes the package. It also asks whether to delete local TokenUse data such as config, credentials, queued events, prompts, cursors, cache, and logs.

If your installed version does not have `tokenuse uninstall`, run `tokenuse logout` first and type `delete` when prompted, then uninstall the formula.

If the `tokenuse` binary is already gone, remove these paths manually:

- `~/Library/LaunchAgents/ai.tokenuse.tracker.plist` on macOS
- `~/.config/systemd/user/tokenuse-tracker.service` on Linux
- `~/.local/share/tokenuse/bin/tokenuse`
- `~/.config/tokenuse/`
- `~/.local/share/tokenuse/`
- `~/.cache/tokenuse/`

## Links

- [Website](https://tokenuse.ai)
- [Documentation](https://tokenuse.ai/docs)
- [Changelog](https://github.com/tokenuse/tokenuse/releases)
- [Security](SECURITY.md)
