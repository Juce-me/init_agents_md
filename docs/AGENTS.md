# docs/AGENTS.md

This file defines where agents store work records: plans, prompts, bugfix notes, and execution summaries.
It does not replace root `AGENTS.md`; root `AGENTS.md` remains the source of truth for agent behavior.

Use this structure only for agent-created work artifacts. Product documentation, API docs, architecture docs, and user-facing docs should live in their own appropriate locations under `docs/`.

The `docs/agents/` namespace exists so temporary or historical agent notes do not look like canonical project documentation.

When agent work produces or modifies any project documentation, the **Doc Review Criteria** section below also applies before the work can be marked `executed`.

## Directory Rules

Use one direct classification folder under `docs/agents/`:

- `docs/agents/features/` for feature plans and implementation notes.
- `docs/agents/prompts/` for prompt changes, prompt experiments, and prompt reviews.
- `docs/agents/bugfixes/` for bug investigations, fixes, and verification notes.
- `docs/agents/reviews/` for documentation reviews, code reviews, and review reports.

Do not put agent work artifacts directly under `docs/` when they fit one of these classifications.

Do not add empty or placeholder folder layers. Use `docs/agents/features/example.md`, not `docs/_empty_folder_/features/example.md`.

Create a classification folder only when adding a real file inside it. Do not commit empty directories, `.keep` files, or placeholder READMEs just to preserve the taxonomy.

## File Naming

Name every artifact with a status prefix so the folder sorts by state at a glance:

```text
STATUS-summary.md
STATUS-YYYY-MM-DD-summary.md   (when creation date carries meaning)
```

- `STATUS`: one of `PLANNED`, `IN-PROGRESS`, `EXECUTED`, `OBSOLETE`. Uppercase, exactly as written, so the boundary between status and summary is visible.
- `YYYY-MM-DD` (optional): creation date in the project's local timezone. Include it when chronology matters for context; omit when it adds noise.
- `summary`: short, lowercase, and hyphen-separated.

Examples:

- `PLANNED-cache-rewrite.md`
- `IN-PROGRESS-cache-rewrite.md`
- `EXECUTED-2026-05-18-cache-rewrite.md`
- `OBSOLETE-old-auth-flow.md`

When status changes, rename the file so the filename and top-level `Status:` line agree. Update links that pointed to the old name. Do not leave a `PLANNED-*` file sitting next to its `EXECUTED-*` copy; the rename replaces, not duplicates.

### No subfolder overrides

A subfolder `AGENTS.md` may add stricter constraints (extra required fields, additional review steps, narrower allowed scopes) but **must not** redefine the naming scheme above or move artifacts out of `docs/agents/<class>/`. Naming and location are set here so that every project using this template stays consistent. If a project needs a genuinely different scheme, change this file at the template level — not in a local override.

### Migration when conventions change

If this naming scheme changes, every existing artifact must be either:

- **Renamed** to the new scheme (preferred), or
- **Marked `obsolete`** under its current name if it no longer reflects current direction.

Do not leave two eras of naming side by side. A folder with both `2026-03-03-foo-design.md` and `EXECUTED-foo.md` is the failure mode this rule prevents: readers cannot tell which convention is current, and neither agents nor humans navigate it reliably. The migration is part of the convention change, not a follow-up task.

## Cross-References

Link related context with stable references rather than free-form prose.

- Cite sibling artifacts by relative path, e.g. `../bugfixes/EXECUTED-cache-stale.md`.
- Cite postmortems by relative path to the `postmortem/` directory.
- Cite pull requests, commits, and issues with full URLs. If the same link appears repeatedly, define it once near the top of the artifact and reuse the reference.
- Do not invent links. If a referenced artifact does not exist yet, say so explicitly instead of fabricating a path.

## Required Header

Every artifact must state status, type, and author near the top:

```markdown
Status: planned
Type: feature
Author: <name-or-handle>
```

`Author` identifies the human responsible for the artifact's current contents. Use a real handle. When an agent edits a human-owned artifact, the human remains the author; the edit is captured in git history, not in this field. Update `Author` only when ownership actually transfers to a different person.

Allowed statuses:

- `planned`: the work has not been executed yet.
- `in-progress`: the work is currently being executed.
- `executed`: the work was completed or attempted and has an outcome.
- `obsolete`: the artifact no longer describes the current direction.

Allowed types match the classification folder under `docs/agents/`:

- `feature`: feature plan or implementation note.
- `prompt`: prompt change, experiment, or review.
- `bugfix`: bug investigation, fix, or verification note.
- `review`: documentation review, code review, or review report.

If a file does not clearly say its status, type, and author, fix that before using it as context.

## Plan Requirements

Every plan must make the intended work unambiguous. Include:

- What exactly changes.
- Forbidden regressions.
- Files allowed to touch.
- Expected behavior.
- Acceptance criteria.

If Superpowers is active, create implementation plans with `writing-plans` and execute them with `subagent-driven-development` when available or `executing-plans` otherwise. This file's location and naming rules still apply unless the user explicitly chooses another path.

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

## Doc Review Criteria

When agent work produces or modifies project documentation (product docs, API docs, architecture docs, user-facing copy), the affected docs must be reviewed against every applicable dimension below before the artifact is marked `executed`. If a dimension does not apply to a given doc, say so explicitly in `Current Accuracy` rather than skipping it silently.

The criteria exist because docs that look plausible but encode the wrong UX flow, an outdated API contract, a leaked secret, or a stale architecture diagram cause more damage than missing docs — readers trust them.

### UI/UX wording and flow

- User-facing copy reads in plain language; no internal jargon, no leaked implementation terms.
- Error messages name the actual problem and the user's next step. No bare error codes without context.
- Terminology is consistent within and across docs. One canonical name per concept; cross-link rather than rename.
- Primary flows are described end-to-end. A first-time reader can follow them without external context.
- Accessibility wording is correct where relevant: alt text, ARIA labels, instructions that do not rely on color alone.

### Backend and API correctness

- Documented request and response shapes match the current code, including required vs optional fields and types.
- Status codes, error codes, and error payloads are enumerated. No undocumented failure modes.
- Versioning and deprecation are explicit. Deprecated endpoints have a removal target and a migration path.
- Authentication, authorization, rate limits, and idempotency guarantees are stated, not implied.
- Examples are runnable and reflect the current schema. Stale examples are worse than no examples.

### Security and privacy

- No secrets, tokens, internal hostnames, production identifiers, absolute local paths, real emails, local machine usernames, or other user-specific data appear in examples, screenshots, or logs shown in docs.
- Authn and authz behavior is documented: who can call what, how scopes work, what fails closed by default.
- PII handling is explicit: what is stored, for how long, where, and how it is deleted or exported on request.
- Threat model assumptions are stated where the doc affects security-sensitive surfaces (auth, payments, admin, file upload).
- Vulnerability disclosure and incident contact paths are findable from the docs a reader is likely to land on first.

### Architecture and contracts

- Architecture docs match the current code: diagrams, component boundaries, and data flows are not stale.
- Public contracts (APIs, events, schemas, CLI flags, config keys) are documented as contracts, with stability guarantees stated.
- Migration paths are documented when contracts change. Old contracts say what replaces them and by when.
- Architecture decisions live in ADRs or an equivalent record. The doc cites the decision rather than re-arguing it.
- Cross-service dependencies and failure modes are stated, not left for readers to reverse-engineer.

A doc-touching artifact's `Outcome` section must record which dimensions were checked and any findings deferred to a follow-up artifact.

## Maintenance Rules

When starting work from an artifact, read its status and current accuracy first.

When completing work, update documentation before ending the session:

- Rename the artifact so its filename status matches the final status.
- Update the artifact to `executed` or `obsolete`.
- Add or refresh `Outcome` and `Current Accuracy`.
- Update the implementation plan, `README.md`, and affected product or project docs so they match the shipped result.
- When the work touched project documentation, verify each affected doc against the **Doc Review Criteria** before marking the artifact `executed`.

When a later change makes an executed artifact inaccurate, either update its `Current Accuracy` section or mark it `obsolete`. Do not leave stale plans looking authoritative.

Delete `obsolete` artifacts once the work they describe is no longer being reread for context. Git history preserves the record. Stale plans living next to active ones confuse new contributors more than they help.
