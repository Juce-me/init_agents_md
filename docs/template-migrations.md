# Template Migrations

Use this guide when a newer `Template version` requires changes beyond a root-only text update, including path moves, auxiliary instruction updates, symlink changes, or cleanup inside preserved sections 10 and 11.

Apply entries newer than the local template version in date order. Before changing anything:

1. Read section 10 of the local `AGENTS.md`; it records the project's actual layout and may intentionally differ from this repository.
2. Check every source and destination. If both exist, stop and show their contents and Git history; never merge directories or choose a winner automatically.
3. Show the proposed moves and instruction-file diffs. File-layout changes and edits to preserved sections require approval.
4. Preserve project-specific content and use repository-relative paths. Do not overwrite local instructions with the template copy.
5. Verify moved files, references, and symlinks before updating the local `Template version`.

## 2026-07-10: Optional Postmortem Relocation

Current new installations use `docs/postmortem/`. Legacy installations using `postmortem/` remain supported, so no move is required merely to adopt the newer root template.

If the user chooses to migrate:

1. If only `postmortem/` exists, preflight that `docs/postmortem/` does not exist, then move the tracked directory with Git.
2. If both paths exist, stop. Show the diff and ask which location is authoritative; do not merge or delete either directory automatically.
3. If the local project already has `docs/AGENTS.md`, compare it with the current template and incorporate the explicit `docs/postmortem/` schema delegation without discarding project-specific rules. Do not install `docs/AGENTS.md` solely for this migration.
4. Compare the moved postmortem instructions and index with the current `docs/postmortem/` templates. Preserve local postmortems and index entries.
5. Confirm `docs/postmortem/CLAUDE.md` and `docs/postmortem/GEMINI.md` are symlinks to the colocated `AGENTS.md`.
6. Update verified path references in section 10, the project README, and affected docs. Search for stale `postmortem/` references and inspect each match rather than replacing blindly.
7. Run the project's documentation checks and confirm the worktree contains only the reviewed migration.

Agent work artifacts remain in the collision-resistant `docs/agents/<class>/` namespace. Do not flatten them into generic `docs/features/`, `docs/prompts/`, `docs/bugfixes/`, or `docs/reviews/` directories.

## 2026-07-10: Section 11 Cleanup

Earlier templates placed two reusable-template rules in section 11 even though that section is preserved for project learnings. If either line below is still present exactly as written, show the cleanup diff and remove it after approval; an edited line may be project-specific and must not be removed automatically.

```text
- Use each project's pinned local runtime manager for project commands: `.venv` for Python, Volta for Node/npm when configured.
- When changing this template, update `Template version` in `AGENTS.md` to the change date.
```

The runtime rule now lives in section 5, where verified project tooling takes precedence. Template-maintenance rules belong in section 10 of the template source and should not be copied into a target project's learnings.

## 2026-08-28: Git Author Identity and Instruction Cleanup

Template version `2026-08-28` uses the configured Git author name for agent artifact ownership, requires agents to discover instructions along the target file's path, makes obsolete-artifact deletion proposal-only, clarifies that branch-readiness verification applies to every installed project, and removes reusable guidance duplicated inside section 10.

The automatic root-only update applies the privacy and instruction-discovery wording but preserves sections 10 and 11 and does not replace auxiliary files. For existing installations, inspect each applicable change and apply it only after approval:

1. If `docs/AGENTS.md` is installed, change the artifact header to `Author: <git-user-name>` and source it from the non-empty output of `git config user.name`. If the value is unset, require the agent to ask instead of inferring a name or hosting-account handle.
2. Replace any automatic instruction to delete obsolete artifacts with a proposal-only rule. Deletion remains subject to the user's requested scope.
3. If section 11 contains the exact earlier branch-readiness learning, clarify that it applies in every installed project without changing its verification requirements.
4. In section 10, remove reusable hierarchy, compatibility-symlink, and artifact-schema rules only when they duplicate the current root guidance exactly. Preserve project-specific conventions and edited local variants.
5. Update an installed copy of the template README only when it is intentionally used as local installation documentation; do not overwrite a project's own README.
