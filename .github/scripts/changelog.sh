#!/bin/bash

# themes/release/changelog.sh
# Dinamic changelog generator by categories

CURRENT_TAG="$GITHUB_REF_NAME"
PREV_TAG=$(git describe --tags --abbrev=0 "${CURRENT_TAG}^" 2>/dev/null || echo "")
COMMIT_RANGE="${PREV_TAG:+$PREV_TAG..}$CURRENT_TAG"

echo "" > body.md

BREAKING_LOGS=$(git log "$COMMIT_RANGE" --grep="!:" --grep="BREAKING CHANGE" --format="%s [\`%h\`](https://github.com/${GITHUB_REPOSITORY}/commit/%H)" | \
        sed -E "s/^[a-z]+!(\([a-zA-Z0-9_-]+\))?:[[:space:]]*/- /" | \
    awk '{print toupper(substr($0,1,3)) substr($0,4)}')

if [ -n "$BREAKING_LOGS" ]; then
    echo -e "## 🚨 BREAKING CHANGES\n> **⚠️ IMPORTANT:** This release introduces architectural changes that are not backward compatible.\n\n$BREAKING_LOGS\n\n***\n" >> body.md
fi

process_category() {
    local prefix="$1"
    local title="$2"

    local logs
    logs=$(git log "$COMMIT_RANGE" --grep="^$prefix" --format="%s [\`%h\`](https://github.com/${GITHUB_REPOSITORY}/commit/%H)" | \
            sed -E "s/^$prefix(\([a-zA-Z0-9_-]+\))?:[[:space:]]*/- /" | \
        awk '{print toupper(substr($0,1,3)) substr($0,4)}')

    if [ -n "$logs" ]; then
        echo -e "### $title\n$logs\n" >> body.md
    fi
}

process_category "feat" "🚀 New Features & Ecosystem"
process_category "fix" "🐛 Bug Fixes"
process_category "style" "🎨 UI & Aesthetic Adjustments"
process_category "docs" "📝 Documentation Changes"
process_category "ci" "🧰 Maintenance & CI Pipeline"
process_category "chore" "🧰 Maintenance & CI Pipeline"
process_category "refactor" "🧰 Maintenance & CI Pipeline"

echo -e "***\n*Full Changelog: https://github.com/${GITHUB_REPOSITORY}/compare/${PREV_TAG:-main}...${CURRENT_TAG}*" >> body.md

cat body.md > ../../changelog.md
