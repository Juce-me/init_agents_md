# Preset: python-web-app

Optional hygiene rules for Python web applications: a Python back-end (Django, Flask, FastAPI, or similar) serving templates, static assets, or a JavaScript front-end.

## How to install

Offer this preset during first install when the project matches the description above. Ask the user whether it makes sense for their project; never apply it without asking. On yes, copy the rules below into section 10 `Conventions` of the project's `AGENTS.md`. Rules placed there survive template auto-updates, which preserve sections 10 and 11.

## Rules

- Split work by feature. One feature per branch and PR; do not bundle unrelated features in one diff.
- Keep front-end and back-end changes separable. When a feature spans both, structure commits so each layer's change can be reviewed on its own.
- Separate languages and layers: Python logic in modules, JavaScript in `.js` files, styles in stylesheets, markup in templates. No inline `<script>` or `<style>` blocks and no `style=` attributes in templates unless the project already does this deliberately.
- Keep business logic out of templates. Templates render context; views and handlers prepare it.
- Follow the project's design system: existing tokens, components, spacing, and typography. Never introduce one-off colors, fonts, or components when a system equivalent exists. Do not redesign the design system unless explicitly asked to.
