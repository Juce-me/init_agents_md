# agents_md

Reusable starter for installing and maintaining a shared `AGENTS.md` instruction file across coding agents.

## Purpose

This project keeps a base `AGENTS.md` template plus compatibility files for tools that read `CLAUDE.md` or `GEMINI.md`. It also includes a lightweight postmortem workflow so projects can turn mistakes into durable rules and action items.

## Install Instructions for New Projects

Install <https://github.com/Juce-me/init_agents_md> into this project.

Fetch <https://raw.githubusercontent.com/Juce-me/init_agents_md/main/AGENTS.md> and save it as `./AGENTS.md` at the project root. If `AGENTS.md` already exists, stop and show the diff before overwriting.

Symlink `CLAUDE.md` and `GEMINI.md` to `AGENTS.md` so Claude Code and Gemini CLI read the same file. Use the right command for the OS:

```bash
ln -s AGENTS.md CLAUDE.md
ln -s AGENTS.md GEMINI.md
```

On Windows, use:

```powershell
New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md
New-Item -ItemType SymbolicLink -Path GEMINI.md -Target AGENTS.md
```

If symlinks fail, fall back to copying the file. If `CLAUDE.md` or `GEMINI.md` already exist with content, do not overwrite them. Prepend `@AGENTS.md` as the first line and leave the rest intact.

Open the new `AGENTS.md`, find section 10 (`Project context`), and fill in only what can be verified by reading the codebase:

- Stack
- Build, test, lint, and run commands from `package.json`, `pyproject.toml`, `Cargo.toml`, or `Makefile`
- Source and test directory layout

Leave anything that cannot be confirmed as `TODO`.

Do not touch section 11. It stays empty by design.

Copy `postmortem/README.md` into the project if it does not already exist. If the project already has a postmortem index, preserve it and merge in any missing conventions:

- Review relevant postmortems before touching related code.
- Copy `postmortem/AGENTS.md` so agents have local postmortem-specific instructions.
- Name new postmortems sequentially as `MRTXXX-short-title.md`.
- Keep postmortems blameless, specific, verified, and action-oriented.
- Update `postmortem/README.md` whenever adding or renaming a postmortem.
- Keep `README.md`, `AGENTS.md`, and `postmortem/README.md` aligned when workflow or structure changes.

When done, tell the user to restart the session so the file loads.

## Current Files

- `AGENTS.md`: Base agent instructions with project context in section 10.
- `CLAUDE.md`: Symlink to `AGENTS.md`.
- `GEMINI.md`: Symlink to `AGENTS.md`.
- `postmortem/AGENTS.md`: Directory-specific instructions for postmortem creation and updates.
- `postmortem/README.md`: Reusable postmortem index and template.
- `README.md`: This project guide and install checklist.
