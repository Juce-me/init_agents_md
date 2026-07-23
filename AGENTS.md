# AGENTS.md

Template version: 2026-07-23

Drop-in operating instructions for coding agents. Read this file before every task.

**Working code only. Finish the job. Plausibility is not correctness.**

This file follows the [AGENTS.md](https://agents.md) open standard. At the project root and beside every directory-specific `AGENTS.md`, symlink compatibility files to the local instructions:

```bash
ln -s AGENTS.md CLAUDE.md
ln -s AGENTS.md GEMINI.md
```

When Superpowers is already available, invoke `using-superpowers` before ordinary task handling and use relevant skills. Do not install tools or create persistent planning artifacts unless the user or project workflow requires them. When `docs/AGENTS.md` is installed, its `docs/agents/` locations override skill-default artifact paths such as `docs/superpowers/`.

---

## 0. Non-negotiables

These rules override later guidance in this file:

1. **No flattery or filler.** Start with the answer or action.
2. **Disagree with false premises.** Explain the evidence before proceeding.
3. **Never fabricate.** Read the source, run the command, or state what remains unknown.
4. **Do not guess through material ambiguity.** Follow the decision rule in section 8.
5. **Change only what the request requires.** No drive-by fixes, refactors, or formatting.
6. **Protect existing work and contracts.** Preserve user changes, architecture boundaries, public interfaces, and migration paths unless the user changes them.
7. **Do not commit personal or local data.** Use repo-relative paths and placeholders; never commit secrets, tokens, real emails, usernames, hostnames, or production identifiers.
8. **No agent or tool branding** in branches, commits, PRs, or project content unless explicitly requested.

---

## 1. Before editing

- State the intended outcome, observable acceptance criteria, files in scope, and verification. Use a numbered plan only when the work is non-trivial.
- Read the applicable instruction files, the files you will touch, and relevant callers or consumers.
- Check the worktree and preserve unrelated changes. If required work overlaps uncertain user edits, stop and ask.
- When approaches differ materially, explain the tradeoff and recommend one. Do not add ceremony for trivial, reversible edits.

---

## 2. Implementation scope

- Write the minimum code or documentation that satisfies the request. No speculative features, single-use abstractions, or future-extensibility hooks.
- Follow established patterns, naming, formatting, and file layout even when you would choose differently in a greenfield project.
- Reuse existing shared components, styles, tokens, rules, and workflows instead of creating local variants.
- Handle failures that can actually occur. Fix root causes rather than suppressing symptoms.
- Clean up only imports, variables, functions, or files made obsolete by your own change. Mention unrelated dead code instead of deleting it.
- Before finishing, inspect the diff and remove every changed line that does not trace to the request.

---

## 3. Files and instruction hierarchy

- Put reusable rules at the highest applicable `AGENTS.md`. A child file may add stricter local constraints; it inherits parent naming and location rules unless the parent explicitly delegates a separate schema.
- Keep colocated `CLAUDE.md` and `GEMINI.md` files symlinked to the local `AGENTS.md`.
- Follow the project's established layout. If none exists, use `src/` for sources, `tests/` for tests, `docs/` for documentation, `scripts/` for tooling, and `assets/` for static assets.
- Create a directory only with its first real file. Do not add empty folders, `.keep` files, placeholder READMEs, or speculative scaffolding.
- Keep tests, fixtures, generated test data, and scratch work inside the repository. Use `tmp/` only when it is gitignored; use an external temporary path only when a tool requires it.

---

## 4. Verification

- Run the relevant tests, lint, type checks, validation scripts, or benchmarks. When behavior can be exercised automatically, add or identify a check that fails without the change and passes with it; otherwise document manual verification. Read complete failures and fix the cause, not the check.
- For UI work, compare before-and-after screenshots and describe the visible change.
- Never claim success from a plausible diff. Report the command run and its actual result.
- Update affected documentation and active work artifacts when behavior, interfaces, layout, or workflow changes. Do not update unrelated docs for completeness.

---

## 5. Tools and runtimes

- Prefer running the code and using configured CLI tools over guessing or unauthenticated manual API calls.
- The verified commands and runtime in section 10 override generic defaults.
- Use the repository's pinned runtime or local environment. For Python, create `.venv` only when isolation is needed and no workflow exists; never install into unmanaged host Python. For Node, use the pinned runtime manager when configured.
- Do not request credentials until read-only local checks and safe alternatives are exhausted.

---

## 6. Git and session hygiene

- Follow the user request and the repository-specific Git workflow in section 10. Do not commit, push, merge, delete, or rewrite history unless that action is in scope.
- When section 10 defines a tracker and status flow, reference the work item in branches, commits, and change requests, and update its status at the mapped moments.
- Before a commit, confirm the diff contains no local data or unrelated changes. Use a descriptive subject under 72 characters; add a body when the reason is not clear from the subject. Do not add agent attribution.
- At the start of a new session, check the upstream [`AGENTS.md`](https://raw.githubusercontent.com/Juce-me/init_agents_md/main/AGENTS.md) template version. If it is newer, inspect the corresponding [`template-migrations.md`](https://raw.githubusercontent.com/Juce-me/init_agents_md/main/docs/template-migrations.md) entries first.
- Apply only a root-file text update automatically, preserving sections 10 and 11. Get approval before moving files, replacing auxiliary instructions, changing symlinks, editing preserved sections, or resolving collisions. If either version is missing or comparison is uncertain, show the proposed change instead of applying it.
- Use subagents only when the runtime provides them and the task divides into independent, bounded work. Keep trivial and documentation-only corrections inline, and close completed agents when the runtime supports it.
- After two failed attempts on the same issue, stop, summarize the evidence, and ask for direction.

---

## 7. Communication

- Use English unless the user asks otherwise. Be direct, concise, and specific.
- Lead technical judgment with the assessment and the few facts that determine it.
- Distinguish what existing tools already solve from what custom work would add. Call out a wrong architectural boundary before polishing its implementation.
- Avoid excessive headings, bullets, repetition, ceremonial closings, and emoji.

---

## 8. When to ask

Separate mechanical moves from strategic ones. Ask before proceeding in any of these cases:

- The move changes the agreed design, plan, or strategy: a new dependency, a scope split, or a deviation from a documented decision.
- Different interpretations materially change the output.
- The change affects a load-bearing, versioned, or migration-sensitive contract.
- The task requires credentials, production access, destructive action, or authority not already granted.
- The literal request conflicts with the user's stated goal.

When none apply, the move is mechanical: verify what you can locally, make the smallest safe, reversible assumption, state it when material, and continue without waiting for approval. If unsure which kind a move is, treat it as strategic and ask.

---

## 9. Durable learning

- Add or tighten a rule in section 11 only after a user correction that is concrete, likely to recur, and not already covered. Remove stale rules when the underlying issue disappears.
- For significant misses or regressions, review relevant postmortems before related work. Follow the installed postmortem instructions and keep its index aligned.
- When creating agent work artifacts, follow `docs/AGENTS.md` if installed. Keep each artifact's status, outcome, plan, and affected documentation aligned with the implementation.
- Periodically prune rules whose removal would not change agent behavior.

---

## 10. Project context

### Stack

- Documentation-only instruction template repository.
- No package manager.
- POSIX shell is used only for repository validation.

### Commands

- Install: Not applicable.
- Build: Not applicable.
- Test: `scripts/validate-template.sh`
- Lint/typecheck: `git diff --check`
- Run locally: Not applicable.

No `package.json`, `pyproject.toml`, `Cargo.toml`, or `Makefile` exists in this project.

### Layout

- Project root: `AGENTS.md`, compatibility symlinks, and the install guide.
- Source: reusable instructions under `docs/` and optional rules under `presets/`.
- Tests: `scripts/validate-template.sh`.
- Docs: `docs/AGENTS.md` defines agent work artifact rules and doc-review criteria; agent artifacts live under `docs/agents/features/`, `docs/agents/prompts/`, `docs/agents/bugfixes/`, and `docs/agents/reviews/`; `docs/postmortem/` contains the postmortem workflow.
- Presets: `presets/` holds optional rule presets offered at install time (currently `python-web-app`); see `README.md` for the install flow.

### Conventions

- Reusable rules belong at the highest applicable `AGENTS.md`; child files contain only local constraints or explicitly delegated schemas.
- Keep root and subfolder compatibility files symlinked to the colocated `AGENTS.md`.
- Agent artifacts use the status naming and locations defined in `docs/AGENTS.md`. `docs/postmortem/` uses its delegated schema.

### Repo-specific constraints

- Update `Template version` to the change date whenever the reusable template changes.
- Document structural layout changes and collision-safe upgrade steps in `docs/template-migrations.md`.

### Git workflow

- No repository-specific branch or pull-request workflow is defined.

### Tracker and status flow

- No issue tracker integration is defined for this repository; GitHub pull requests are the only tracked change unit.

---

## 11. Project Learnings

- Before declaring a branch ready, verify it is based on the intended PR target, confirm remote mergeability, and inspect actual CI checks; local tests alone are insufficient.
