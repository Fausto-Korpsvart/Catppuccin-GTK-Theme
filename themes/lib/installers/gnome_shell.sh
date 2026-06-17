#!/usr/bin/env bash

# Catppuccin GTK Theme: GNOME Shell Installer
# Compiles and deploys GNOME Shell theme components and assets.
# Author: @fkorpsvart | License: GPL-3.0

# Compiles and deploys the GNOME Shell theme files.
# Args:
#   1: THEME_DIR - Target theme variant directory
#   2: color     - Color scheme mode suffix (-Light/-Dark)
#   3: theme     - Accent variant suffix
#   4: ctype     - Background scheme suffix
install_gnome_shell() {
    local THEME_DIR="${1}"
    local color="${2}"
    local theme="${3}"
    local ctype="${4}"

    # Resolve dark mode asset path suffix
    local ELSE_DARK=""
    if [[ "${color}" == "-Dark" ]]; then
        ELSE_DARK="${color}"
    fi

    # Prepare target directory
    local display_dir=$(get_display_path "${THEME_DIR}")
    log_path "Shell" "${display_dir}/gnome-shell"
    update_progress "Deploying Shell assets..."
    run_safe mkdir -p "${THEME_DIR}/gnome-shell"

    # Deploy static stylesheet
    run_safe cp -r "${SRC_DIR}/main/gnome-shell/pad-osd.css" "${THEME_DIR}/gnome-shell"

    # Compile SASS style sheets
    if [[ "${DRY_RUN:-}" != "true" ]]; then
        update_progress "Compiling Shell styles (${color#-})..."
        compile_sass "${SRC_DIR}/main/gnome-shell/gnome-shell${color}.scss" "${THEME_DIR}/gnome-shell/gnome-shell.css"
    fi

    # Deploy SVG assets
    log_debug "Deploying GNOME Shell assets..."
    run_safe cp -r "${SRC_DIR}/assets/gnome-shell/common-assets"            "${THEME_DIR}/gnome-shell/assets"
    run_safe cp -r "${SRC_DIR}/assets/gnome-shell/assets${ELSE_DARK}/"*.svg "${THEME_DIR}/gnome-shell/assets"
    run_safe cp -r "${SRC_DIR}/assets/gnome-shell/theme${theme}${ctype}/"*.svg "${THEME_DIR}/gnome-shell/assets"

    # Create standard GNOME Shell symbolic links
    if [[ "${DRY_RUN:-}" != "true" ]]; then
        local GS_DIR="${THEME_DIR}/gnome-shell"
        run_safe ln -sf "assets/no-events.svg"        "${GS_DIR}/no-events.svg"
        run_safe ln -sf "assets/process-working.svg"  "${GS_DIR}/process-working.svg"
        run_safe ln -sf "assets/no-notifications.svg" "${GS_DIR}/no-notifications.svg"
    fi
}
