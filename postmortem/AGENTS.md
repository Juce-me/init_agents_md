# postmortem/AGENTS.md

Directory-specific instructions for creating and updating postmortems.

## When to create a postmortem

Create a postmortem for significant misses, regressions, incidents, repeated mistakes, or any issue where a durable learning would prevent future rework.

Before touching related code, review existing postmortems in this directory and apply any relevant lessons.

## File naming

- Use `MRTXXX-short-title.md`.
- Number postmortems sequentially in creation order, oldest first.
- Keep titles short, lowercase, and hyphen-separated after the ID.

## Required content

Each postmortem must be blameless, specific, verified, and actionable. Include:

- Impact
- Root cause
- Timeline when useful
- Resolution
- Verification
- Lessons learned
- Prevention
- Concrete action items
- References to commits, files, logs, screenshots, issues, or PRs when available

## Index maintenance

When adding, renaming, or deleting a postmortem:

- Update `postmortem/README.md`.
- Keep entries in creation order.
- Update summary counts or status tables if the index includes them.

## Relationship to AGENTS.md

Only add a lesson to root `AGENTS.md` section 11 when it should guide future agent sessions across the project. Keep one-off incident detail in the postmortem file instead.
