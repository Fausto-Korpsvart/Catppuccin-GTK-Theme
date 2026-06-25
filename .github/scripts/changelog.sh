#!/bin/bash

# .github/scripts/changelog.sh

CURRENT_TAG="$GITHUB_REF_NAME"
CLEAN_VERSION="${CURRENT_TAG#v}"

PREV_TAG=$(git describe --tags --abbrev=0 "${CURRENT_TAG}^" 2>/dev/null || echo "")
COMMIT_RANGE="${PREV_TAG:+$PREV_TAG..}$CURRENT_TAG"

echo "" > body.md

MANUAL_CHANGELOG="../../CHANGELOG.md"

if [ -f "$MANUAL_CHANGELOG" ]; then
    MANUAL_NOTES=$(sed -n "/## \[$CLEAN_VERSION\]/,/## \[/p" "$MANUAL_CHANGELOG" | sed '1d;$d')

    if [ -n "$MANUAL_NOTES" ]; then
        echo -e "$MANUAL_NOTES\n" >> body.md
        echo -e "***\n" >> body.md
    fi
else
    echo -e "## Release $CURRENT_TAG\n" >> body.md
fi

ALL_COMMITS=$(git log "$COMMIT_RANGE" --format="%s [\`%h\`](https://github.com/${GITHUB_REPOSITORY}/commit/%H)")

if [ -n "$ALL_COMMITS" ]; then
    echo -e "<details>" >> body.md
    echo -e "<summary><b>🛠️ Technical Changelog (Commits)</b></summary>\n" >> body.md

    while IFS= read -r line; do
        echo -e "- $line" >> body.md
    done <<< "$ALL_COMMITS"

    echo -e "\n</details>\n" >> body.md
fi

echo -e "*Full Changelog: https://github.com/${GITHUB_REPOSITORY}/compare/${PREV_TAG:-main}...${CURRENT_TAG}*" >> body.md

cat body.md > ../../changelog.md
