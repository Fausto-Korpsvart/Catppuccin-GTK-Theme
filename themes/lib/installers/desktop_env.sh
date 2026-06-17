#!/usr/bin/env bash

# Catppuccin GTK Theme: Desktop Environments Installer
# Deploys theme variants for Cinnamon, Metacity, and XFWM4 (XFCE).
# Author: @fkorpsvart | License: GPL-3.0

# Deploys Cinnamon, Metacity, and XFWM4 components for a variant.
# Args:
#   1: THEME_DIR - Target theme variant directory
#   2: color     - Color scheme mode suffix (-Light/-Dark)
#   3: theme     - Accent variant suffix
#   4: ctype     - Background scheme suffix
#   5: window    - Window button layout suffix
install_desktop_env() {
    local THEME_DIR="${1}"
    local color="${2}"
    local theme="${3}"
    local ctype="${4}"
    local window="${5}"

    # Resolve Light/Dark asset path suffixes
    local ELSE_LIGHT=""
    local ELSE_DARK=""
    if [[ "${color}" == '-Light' ]]; then
        ELSE_LIGHT="${color}"
    fi
    if [[ "${color}" == '-Dark' ]]; then
        ELSE_DARK="${color}"
    fi

    local display_dir=$(get_display_path "${THEME_DIR}")

    # Cinnamon component deployment
    log_path "Cinnamon" "${display_dir}/cinnamon"
    update_progress "Deploying Cinnamon assets..."
    run_safe mkdir -p "${THEME_DIR}/cinnamon"
    run_safe cp -r "${SRC_DIR}/assets/cinnamon/common-assets"                              "${THEME_DIR}/cinnamon/assets"
    run_safe cp -r "${SRC_DIR}/assets/cinnamon/assets${ELSE_DARK}/"*.svg                   "${THEME_DIR}/cinnamon/assets"
    run_safe cp -r "${SRC_DIR}/assets/cinnamon/theme${theme}${ctype}/"*.svg                "${THEME_DIR}/cinnamon/assets"
    compile_sass "${SRC_DIR}/main/cinnamon/cinnamon${color}.scss"                         "${THEME_DIR}/cinnamon/cinnamon.css"
    run_safe cp -r "${SRC_DIR}/assets/cinnamon/thumbnails/thumbnail${theme}${ctype}${color}.png" "${THEME_DIR}/cinnamon/thumbnail.png"

    # Metacity component deployment
    log_path "Metacity" "${display_dir}/metacity-1"
    update_progress "Deploying Metacity assets..."
    run_safe mkdir -p "${THEME_DIR}/metacity-1"
    run_safe cp -r "${SRC_DIR}/main/metacity-1/metacity-theme-3${window}${color}.xml"    "${THEME_DIR}/metacity-1/metacity-theme-3.xml"
    run_safe cp -r "${SRC_DIR}/assets/metacity-1/assets${window}"                        "${THEME_DIR}/metacity-1/assets"
    run_safe cp -r "${SRC_DIR}/assets/metacity-1/thumbnail${ELSE_DARK}.png"              "${THEME_DIR}/metacity-1/thumbnail.png"

    # Create compatibility symlinks
    run_safe ln -sf metacity-theme-3.xml "${THEME_DIR}/metacity-1/metacity-theme-1.xml"
    run_safe ln -sf metacity-theme-3.xml "${THEME_DIR}/metacity-1/metacity-theme-2.xml"

    # XFWM4 component deployment (with HiDPI & Extra-HiDPI scaling)
    log_path "XFWM4" "${display_dir}/xfwm4"
    update_progress "Deploying XFWM4 assets..."

    # Standard resolution
    run_safe mkdir -p "${THEME_DIR}/xfwm4"
    run_safe cp -r "${SRC_DIR}/assets/xfwm4/assets${ELSE_LIGHT}${ctype}${window}/"*.png  "${THEME_DIR}/xfwm4"
    run_safe cp -r "${SRC_DIR}/main/xfwm4/themerc${ELSE_LIGHT}"                          "${THEME_DIR}/xfwm4/themerc"

    # HiDPI resolution (~1.5x)
    run_safe mkdir -p "${THEME_DIR}-hdpi/xfwm4"
    run_safe cp -r "${SRC_DIR}/assets/xfwm4/assets${ELSE_LIGHT}${ctype}${window}-hdpi/"*.png  "${THEME_DIR}-hdpi/xfwm4"
    run_safe cp -r "${SRC_DIR}/main/xfwm4/themerc${ELSE_LIGHT}"                               "${THEME_DIR}-hdpi/xfwm4/themerc"
    run_safe sed -i 's/button_offset=6/button_offset=9/' "${THEME_DIR}-hdpi/xfwm4/themerc"

    # Extra-HiDPI resolution (2x)
    run_safe mkdir -p "${THEME_DIR}-xhdpi/xfwm4"
    run_safe cp -r "${SRC_DIR}/assets/xfwm4/assets${ELSE_LIGHT}${ctype}${window}-xhdpi/"*.png "${THEME_DIR}-xhdpi/xfwm4"
    run_safe cp -r "${SRC_DIR}/main/xfwm4/themerc${ELSE_LIGHT}"                               "${THEME_DIR}-xhdpi/xfwm4/themerc"
    run_safe sed -i 's/button_offset=6/button_offset=12/' "${THEME_DIR}-xhdpi/xfwm4/themerc"
}
