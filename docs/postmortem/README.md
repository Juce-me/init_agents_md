# Postmortem Index

This directory contains blameless postmortems for significant misses, regressions, incidents, or repeated mistakes. Use it to preserve project memory and turn failures into concrete prevention work.

Postmortems serve to:

- Capture what happened and why.
- Record how the fix was verified.
- Identify prevention work and owners where applicable.
- Feed durable lessons back into `AGENTS.md` section 11 only when the rule should guide future agent sessions.

## Postmortem List

Add entries here in creation order:

| ID | Title | Date | Severity | Status |
| --- | --- | --- | --- | --- |
| TODO | TODO | TODO | TODO | TODO |

## Postmortem Template

Each postmortem should follow this structure:

```markdown
# Postmortem MRTXXX: [Title]

**Date**: YYYY-MM-DD
**Severity**: [Critical/High/Medium/Low]
**Status**: [Resolved/In Progress/Monitoring]
**Author**: [Name]

## Summary
Brief description of the issue.

## Impact
- Users or workflows affected
- Duration or scope
- Symptoms

## Root Cause
Technical details of what went wrong.

## Timeline
Chronological events.

## Resolution
How it was fixed.

## Verification
How the fix was validated.

## Lessons Learned
- What went well
- What could be improved

## Action Items
- [x] Completed items
- [ ] Pending items

## Prevention
How to avoid similar issues.

## Related Issues
Links to related postmortems, issues, PRs, or incidents.

## References
Commits, files, logs, screenshots, or documentation.
```

## Contributing

When creating a new postmortem:

1. Name it sequentially as `MRTXXX-short-title.md`, oldest first.
2. Be blameless: focus on systems, assumptions, and verification gaps.
3. Be specific: include files, commands, logs, screenshots, or data when useful.
4. Be actionable: list concrete follow-up items.
5. Update this README with the new entry.
6. Update `AGENTS.md` only when the lesson should become a durable future rule.
