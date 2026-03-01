# AGENTS.md - TokenUse Homebrew Tap

Authoritative agent guide for this repository (Codex + Claude compatible).

## Purpose

This repo owns the Homebrew formula for TokenUse CLI distribution.

## Mandatory Read Order

1. `AGENTS.md` (this file)
2. `Formula/AGENTS.md`
3. `README.md`

## Instruction Precedence

1. Root `AGENTS.md`
2. Nearest folder `AGENTS.md`
3. `CLAUDE.md` shim

## Skills

- `skill-formula-version-bump`: update `version` and artifact URLs together.
- `skill-checksum-sync`: update all platform SHA256 values from release `checksums.txt`.
- `skill-install-smoke`: validate formula installs and `tokenuse version` works.

## Plugins And Tools

- Core: `git`, `rg`, `curl`
- Domain: `brew`, `shasum`

## Safety Rails

- Never publish a version with partial checksum updates.
- Keep formula platform matrix aligned with CLI release artifacts.
- Do not change install path conventions unless CLI packaging changed.

## Definition Of Done

- Formula version and four platform checksums are correct.
- README install commands remain valid.
- Changes are limited to Homebrew tap scope.

## AGENTS Hooks

- Install local hooks: `bash scripts/setup-git-hooks.sh`
- Pre-commit guard: `.githooks/pre-commit` -> `devops/agents/verify-agents.sh --staged`
- CI guard: `.github/workflows/agents-guard.yml`
- Temporary bypass (rare): `SKIP_AGENTS_GUARD=1 git commit -m "..."`
