# AGENTS.md - Formula

## Folder Purpose

`Formula/` contains the Homebrew formula definition (`tokenuse.rb`) for TokenUse CLI installation.

## What Lives Here

- `tokenuse.rb`: package metadata, version, platform URLs/checksums, install/test blocks.

## Local Rules

- Update `version`, URLs, and checksums in one change.
- Keep `test do` lightweight and deterministic (`tokenuse version`).
- Preserve supported OS/arch matrix unless release artifacts changed.
