# Agent Work Artifacts

This file defines where agents store work records: plans, prompts, bugfix notes, and execution summaries.
It does not replace root `AGENTS.md`; root `AGENTS.md` remains the source of truth for agent behavior.

Use this structure only for agent-created work artifacts. Product documentation, API docs, architecture docs, and user-facing docs should live in their own appropriate locations under `docs/`.

The `docs/agents/` namespace exists so temporary or historical agent notes do not look like canonical project documentation.

## Directory Rules

Use one direct classification folder under `docs/agents/`:

- `docs/agents/features/` for feature plans and implementation notes.
- `docs/agents/prompts/` for prompt changes, prompt experiments, and prompt reviews.
- `docs/agents/bugfixes/` for bug investigations, fixes, and verification notes.

Do not put agent work artifacts directly under `docs/` when they fit one of these classifications.

Do not add empty or placeholder folder layers. Use `docs/agents/features/example.md`, not `docs/_empty_folder_/features/example.md`.

Create a classification folder only when adding a real file inside it. Do not commit empty directories, `.keep` files, or placeholder READMEs just to preserve the taxonomy.

## Required Status

Every artifact must state whether it is planned, active, executed, or obsolete near the top:

```markdown
Status: planned
Type: feature
```

Allowed statuses:

- `planned`: the work has not been executed yet.
- `in-progress`: the work is currently being executed.
- `executed`: the work was completed or attempted and has an outcome.
- `obsolete`: the artifact no longer describes the current direction.

If a file does not clearly say whether it was planned or executed, fix that before using it as context.

## Source Of Truth

Before execution, the artifact is the source of truth for intended work.

During execution, the artifact and current diff must be read together. If implementation diverges from the artifact, update the artifact with the divergence instead of pretending the original plan still applies.

After execution, shipped code, tests, and current product documentation are the source of truth. The artifact becomes historical context and must say whether it still matches reality.

Completed artifacts must include an outcome:

```markdown
## Outcome

Implemented with changes. The implementation is now the source of truth.

## Current Accuracy

Partially accurate: the goal and verification still apply, but the file layout changed during implementation.
```

Use one of these outcome meanings:

- `Implemented as planned`: the artifact still describes the result.
- `Implemented with changes`: the result differs; summarize the difference.
- `Superseded by implementation`: the code is correct and the old plan should not guide future work.
- `Obsolete before execution`: the work was not done and should not be picked up without a fresh review.

## Maintenance Rules

When starting work from an artifact, read its status and current accuracy first.

When completing work, update the artifact to `executed` or `obsolete` before ending the session.

When a later change makes an executed artifact inaccurate, either update its `Current Accuracy` section or mark it `obsolete`. Do not leave stale plans looking authoritative.
