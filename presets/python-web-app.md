# Preset: python-web-app

Preset version: 2026-07-10

Optional hygiene rules for Python web applications: a Python back-end (Django, Flask, FastAPI, or similar) serving templates or front-end assets.

## How to install

Offer this preset when the project matches the description above. Ask whether it fits the project's established framework and workflow; never apply it without approval. Copy the complete marked block below into section 10 `Conventions` of the project's `AGENTS.md`.

Installation must be idempotent:

- If no `python-web-app` block exists, add it once after approval.
- If exactly one block with the same version exists, compare the complete block. Make no change only when it is identical; if it diverged, treat it as a local customization and show the diff before asking whether to replace it.
- If an older version exists, show the block diff and replace that block only after approval.
- If a newer version exists, do not downgrade it.
- If markers are missing, malformed, or duplicated, stop and show the existing content; never append or repair a block automatically.

## Installable block

<!-- BEGIN PRESET python-web-app v2026-07-10 -->
- Follow the project's established framework boundaries. Keep Python behavior in Python modules and front-end behavior in the framework's native modules, components, or assets; do not force `.js` files or standalone stylesheets when the verified toolchain uses TypeScript, JSX/TSX, single-file components, CSS modules, or CSS-in-JS.
- Keep business logic out of server-rendered templates. Views, handlers, or services prepare context; templates may use presentation-only conditions, loops, and formatting.
- When the project uses external asset files, avoid adding inline `<script>`, `<style>`, or `style=` content to server-rendered templates. Follow an established framework convention when inline or component-scoped code is intentional or required.
<!-- END PRESET python-web-app -->
