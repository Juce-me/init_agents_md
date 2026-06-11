# agents_md

Reusable starter for installing and maintaining a shared `AGENTS.md` instruction file across coding agents.

## Purpose

This project keeps a versioned base `AGENTS.md` template plus compatibility files for tools that read `CLAUDE.md` or `GEMINI.md`. It also includes lightweight workflows for agent work artifacts and postmortems so projects can keep plans, prompts, fixes, and durable lessons organized.

## Install Instructions for New Projects

To install, copy-paste in your vibe-coding environment:

> Install <https://github.com/Juce-me/init_agents_md> into this project.
>
> Fetch <https://raw.githubusercontent.com/Juce-me/init_agents_md/main/AGENTS.md> and save it as `./AGENTS.md` at the project root. If `AGENTS.md` already exists, stop and show the diff before overwriting.
>
> Keep the `Template version:` line intact. Future agent sessions use it to check upstream automatically and apply a newer version without asking or announcing.
>
> If the agent runtime supports Superpowers, install or enable Superpowers for this project on first start and verify that the `using-superpowers` skill can be invoked. If Superpowers is unavailable, record that limitation in the session and proceed with `AGENTS.md` as the fallback.
>
> Symlink `CLAUDE.md` and `GEMINI.md` to `AGENTS.md` so Claude Code and Gemini CLI read the same file. Use the right command for the OS:
>
> ```bash
> ln -s AGENTS.md CLAUDE.md
> ln -s AGENTS.md GEMINI.md
> ```
>
> If symlinks fail, fall back to copying the file. If `CLAUDE.md` or `GEMINI.md` already exist with content, do not overwrite them. Prepend `@AGENTS.md` as the first line and leave the rest intact.
>
> For every directory-specific `AGENTS.md` copied into a subfolder, create colocated `CLAUDE.md` and `GEMINI.md` symlinks to that local `AGENTS.md`.
>
> Open the new `AGENTS.md`, find section 10 (`Project context`), and fill in only what can be verified by reading the codebase:
>
> - Stack
> - Build, test, lint, and run commands from `package.json`, `pyproject.toml`, `Cargo.toml`, or `Makefile`
> - Source and test directory layout
>
> Leave anything that cannot be confirmed as `TODO`.
>
> Keep development and test artifacts inside the project: tests under `tests/`, disposable scratch work under `tmp/`, and command examples using repo-relative paths. Ensure `tmp/` is listed in `.gitignore` before using it.
>
> Do not touch section 11. It stays empty by design.
>
> For implementation plans and execution, use active Superpowers skills when available: `writing-plans` for plan creation, then `subagent-driven-development` when the platform supports subagents or `executing-plans` for inline execution.
>
> Copy `postmortem/README.md` into the project if it does not already exist. If the project already has a postmortem index, preserve it and merge in any missing conventions:
>
> - Review relevant postmortems before touching related code.
> - Copy `postmortem/AGENTS.md` so agents have local postmortem-specific instructions.
> - Symlink `postmortem/CLAUDE.md` and `postmortem/GEMINI.md` to `postmortem/AGENTS.md`.
> - Name new postmortems sequentially as `MRTXXX-short-title.md`.
> - Keep postmortems blameless, specific, verified, and action-oriented.
> - Update `postmortem/README.md` whenever adding or renaming a postmortem.
> - Keep `README.md`, `AGENTS.md`, and `postmortem/README.md` aligned when workflow or structure changes.
>
> Copy `docs/AGENTS.md` into the project if the team wants agents to keep work artifacts. Store real files under direct classification folders: `docs/agents/features/`, `docs/agents/prompts/`, `docs/agents/bugfixes/`, or `docs/agents/reviews/`. Name artifacts as `STATUS-summary.md` (or `STATUS-YYYY-MM-DD-summary.md` when the creation date carries meaning), where `STATUS` is one of `PLANNED`, `IN-PROGRESS`, `EXECUTED`, `OBSOLETE`. On completion, update the artifact status/outcome plus the implementation plan, `README.md`, and affected docs. Do not create empty placeholder directories.
>
> Symlink `docs/CLAUDE.md` and `docs/GEMINI.md` to `docs/AGENTS.md`.
>
> When done, tell the user to restart the session so the file loads.

## Current Files

- `AGENTS.md`: Versioned base agent instructions with project context in section 10.
- `CLAUDE.md`: Symlink to `AGENTS.md`.
- `GEMINI.md`: Symlink to `AGENTS.md`.
- `docs/AGENTS.md`: Rules for agent work artifacts, naming, status, and source of truth.
- `docs/CLAUDE.md`: Symlink to `docs/AGENTS.md`.
- `docs/GEMINI.md`: Symlink to `docs/AGENTS.md`.
- `postmortem/AGENTS.md`: Directory-specific instructions for postmortem creation and updates.
- `postmortem/CLAUDE.md`: Symlink to `postmortem/AGENTS.md`.
- `postmortem/GEMINI.md`: Symlink to `postmortem/AGENTS.md`.
- `postmortem/README.md`: Reusable postmortem index and template.
- `README.md`: This project guide and install checklist.
