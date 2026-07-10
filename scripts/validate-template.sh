#!/bin/sh

set -eu
LC_ALL=C
export LC_ALL

repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

fail() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

require_file() {
    [ -f "$1" ] || fail "missing required file: $1"
    git ls-files --error-unmatch -- "$1" >/dev/null 2>&1 || fail "required file must be tracked or staged: $1"
}

version_value() {
    file=$1
    prefix=$2
    value=$(awk -v prefix="$prefix" '
        index($0, prefix) == 1 {
            count++
            value = substr($0, length(prefix) + 1)
        }
        END {
            if (count == 1) {
                print value
            }
        }
    ' "$file")

    count=$(awk -v prefix="$prefix" 'index($0, prefix) == 1 { count++ } END { print count + 0 }' "$file")
    [ "$count" -eq 1 ] || fail "$file must contain exactly one $prefix declaration"
    printf '%s\n' "$value" | grep -Eq '^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$' || fail "$file has an invalid version: $value"
    printf '%s\n' "$value"
}

check_symlink() {
    path=$1
    mode=$(git ls-files -s -- "$path" | awk 'NR == 1 { print $1 }')
    [ "$mode" = "120000" ] || fail "$path must be tracked as a Git symlink"
    [ "$(git show ":$path")" = "AGENTS.md" ] || fail "$path must target the colocated AGENTS.md"
    git diff --quiet -- "$path" || fail "$path differs from its tracked symlink target"
    [ -f "$path" ] || fail "$path is a broken symlink"
}

repository_files=$(
    {
        git ls-files
        git ls-files --others --exclude-standard
    } | sort -u
)

for path in \
    AGENTS.md \
    README.md \
    docs/AGENTS.md \
    docs/template-migrations.md \
    docs/postmortem/AGENTS.md \
    docs/postmortem/README.md \
    presets/python-web-app.md \
    scripts/validate-template.sh
do
    require_file "$path"
done

for path in \
    CLAUDE.md \
    GEMINI.md \
    docs/CLAUDE.md \
    docs/GEMINI.md \
    docs/postmortem/CLAUDE.md \
    docs/postmortem/GEMINI.md
do
    check_symlink "$path"
done

template_version=$(version_value AGENTS.md 'Template version: ')
preset_version=$(version_value presets/python-web-app.md 'Preset version: ')

[ "$(sed -n '1p' presets/python-web-app.md)" = "# Preset: python-web-app" ] || fail "preset heading must match presets/python-web-app.md"
marker_state=$(awk '
    index($0, "<!-- BEGIN PRESET python-web-app ") == 1 {
        begin_count++
        begin_line = NR
        in_block = 1
        next
    }
    $0 == "<!-- END PRESET python-web-app -->" {
        end_count++
        end_line = NR
        in_block = 0
        next
    }
    index($0, "<!-- END PRESET python-web-app") == 1 { malformed_count++ }
    in_block && $0 ~ /^- / { rule_count++ }
    END {
        if (malformed_count != 0) print "malformed marker"
        else if (begin_count != 1 || end_count != 1) print "marker count"
        else if (begin_line >= end_line) print "marker order"
        else if (rule_count == 0) print "empty block"
        else print "ok"
    }
' presets/python-web-app.md)
[ "$marker_state" = "ok" ] || fail "python-web-app preset has invalid $marker_state"
grep -Fq "<!-- BEGIN PRESET python-web-app v$preset_version -->" presets/python-web-app.md || fail "preset marker version must match Preset version"

flat_artifact_error=$(printf '%s\n' "$repository_files" | awk -F/ '
    $1 == "docs" && $2 ~ /^(features|prompts|bugfixes|reviews)$/ && $NF ~ /^(PLANNED|IN-PROGRESS|EXECUTED|OBSOLETE)-.*\.md$/ { print }
')
[ -z "$flat_artifact_error" ] || fail "agent artifact must use docs/agents/: $flat_artifact_error"

if printf '%s\n' "$repository_files" | grep -Eq '^postmortem/'; then
    fail "template source still contains the legacy postmortem/ layout"
fi

artifact_error=$(printf '%s\n' "$repository_files" | awk -F/ '
    $1 == "docs" && $2 == "agents" {
        if (NF != 4) { print; next }
        if ($3 !~ /^(features|prompts|bugfixes|reviews)$/) { print; next }
        if ($NF ~ /^(AGENTS|CLAUDE|GEMINI)\.md$/) { next }
        if ($NF !~ /^(PLANNED|IN-PROGRESS|EXECUTED|OBSOLETE)-.*\.md$/) { print }
    }
')
[ -z "$artifact_error" ] || fail "invalid docs/agents artifact path: $artifact_error"

for path in docs/agents/features/ docs/agents/prompts/ docs/agents/bugfixes/ docs/agents/reviews/
do
    grep -Fq "$path" AGENTS.md || fail "AGENTS.md is missing canonical artifact path $path"
    grep -Fq "$path" README.md || fail "README.md is missing canonical artifact path $path"
    grep -Fq "$path" docs/AGENTS.md || fail "docs/AGENTS.md is missing canonical artifact path $path"
done

grep -Fq 'The `docs/postmortem/` subtree is explicitly delegated to `docs/postmortem/AGENTS.md`' docs/AGENTS.md || fail "docs/AGENTS.md must explicitly delegate the postmortem subtree"
grep -Fq '## 2026-07-10: Optional Postmortem Relocation' docs/template-migrations.md || fail "postmortem migration entry is missing"
grep -Fq '## 2026-07-10: Section 11 Cleanup' docs/template-migrations.md || fail "section 11 migration entry is missing"

if grep -Fq 'pinned local runtime manager for project commands: `.venv` for Python, Volta for Node/npm when configured.' AGENTS.md; then
    fail "legacy runtime guidance must not remain in section 11"
fi
if grep -Fq 'When changing this template, update `Template version` in `AGENTS.md` to the change date.' AGENTS.md; then
    fail "template maintenance guidance must not remain in section 11"
fi

git diff --check
git diff --cached --check

printf 'Template validation passed (template %s, python-web-app preset %s).\n' "$template_version" "$preset_version"
