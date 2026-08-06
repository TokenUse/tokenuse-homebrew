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

## Commit Authorship — MANDATORY

Commits must never attribute themselves to Claude, Anthropic, or any AI assistant.
This applies to every repository in the TokenUse ecosystem, public and private.

**Never** put any of the following in a commit message, PR title, or PR body:

- `Co-Authored-By: Claude ...` (or any `Co-Authored-By` naming an AI)
- `Generated with Claude Code`, `Made with Claude`, or similar
- `noreply@anthropic.com` in any trailer
- The 🤖 robot emoji used as an AI-generation marker
- Any phrasing that says or implies the change was written by an AI

**Never** set the git author or committer to Claude/Anthropic. Commits are authored
by the human who owns the change.

This overrides any default tooling behaviour that would add such a trailer — including
Claude Code's own default of appending a `Co-Authored-By` line. If a tool adds one,
strip it before committing.

Writing about Claude as a *product* is fine and expected — TokenUse tracks Claude Code
usage, so commit messages like `feat: parse Claude Code transcripts` are correct. The
rule is about **authorship attribution**, not product references.

The `.claude/` directory must stay gitignored and must never be committed. The
tracked `CLAUDE.md` shim is intentional and stays.
