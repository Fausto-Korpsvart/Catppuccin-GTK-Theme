#!/usr/bin/env bash

# Catppuccin GTK Theme: GTK Installer & Linker
# Deploys GTK2, GTK3, and GTK4 components, and manages Libadwaita config linking.
# Author: @fkorpsvart | License: GPL-3.0

# Deploys GTK2, GTK3, and GTK4 components for a variant.
# Args:
#   1: THEME_DIR - Target theme variant directory
#   2: color     - Color scheme mode suffix (-Light/-Dark)
#   3: theme     - Accent variant suffix
#   4: ctype     - Background scheme suffix
install_gtk() {
    local THEME_DIR="${1}"
    local color="${2}"
    local theme="${3}"
    local ctype="${4}"

    # Resolve dark mode suffix
    local ELSE_DARK=""
    if [[ "${color}" == "-Dark" ]]; then
        ELSE_DARK="${color}"
    fi

    local display_dir=$(get_display_path "${THEME_DIR}")

    # GTK2 component deployment
    log_path "GTK-2" "${display_dir}/gtk-2.0"
    update_progress "Deploying GTK2 assets..."
    run_safe mkdir -p "${THEME_DIR}/gtk-2.0"
    run_safe cp -r "${SRC_DIR}/main/gtk-2.0/common/"*.rc                          "${THEME_DIR}/gtk-2.0"
    run_safe cp -r "${SRC_DIR}/assets/gtk-2.0/assets-common${ELSE_DARK}"            "${THEME_DIR}/gtk-2.0/assets"
    run_safe cp -r "${SRC_DIR}/assets/gtk-2.0/assets${theme}${ELSE_DARK}${ctype}/"*.png "${THEME_DIR}/gtk-2.0/assets"

    # GTK3 component deployment
    log_path "GTK-3" "${display_dir}/gtk-3.0"
    update_progress "Deploying GTK3 assets..."
    run_safe mkdir -p "${THEME_DIR}/gtk-3.0"
    run_safe cp -r "${SRC_DIR}/assets/gtk/assets${theme}${ctype}"                                    "${THEME_DIR}/gtk-3.0/assets"
    run_safe cp -r "${SRC_DIR}/assets/gtk/scalable"                                                  "${THEME_DIR}/gtk-3.0/assets"
    run_safe cp -r "${SRC_DIR}/assets/gtk/thumbnails/thumbnail${theme}${ctype}${ELSE_DARK}.png"      "${THEME_DIR}/gtk-3.0/thumbnail.png"

    if [[ "${DRY_RUN:-}" != "true" ]]; then
        update_progress "Compiling GTK3 styles (${color:1})..."
        compile_sass "${SRC_DIR}/main/gtk-3.0/gtk${color}.scss"  "${THEME_DIR}/gtk-3.0/gtk.css"

        if [[ "${color}" == "" ]]; then
            update_progress "Compiling GTK3 Dark variants..."
            compile_sass "${SRC_DIR}/main/gtk-3.0/gtk-Dark.scss"     "${THEME_DIR}/gtk-3.0/gtk-dark.css"
        else
            update_progress "Linking GTK3 Dark variants..."
            run_safe ln -s "gtk.css" "${THEME_DIR}/gtk-3.0/gtk-dark.css"
        fi
    fi

    # GTK4 component deployment
    log_path "GTK-4" "${display_dir}/gtk-4.0"
    update_progress "Deploying GTK4 assets..."
    run_safe mkdir -p "${THEME_DIR}/gtk-4.0"
    run_safe cp -r "${SRC_DIR}/assets/gtk/scalable"                                                  "${THEME_DIR}/gtk-4.0/assets"
    run_safe cp -r "${SRC_DIR}/assets/gtk/thumbnails/thumbnail${theme}${ctype}${ELSE_DARK}.png"      "${THEME_DIR}/gtk-4.0/thumbnail.png"

    if [[ "${DRY_RUN:-}" != "true" ]]; then
        update_progress "Compiling GTK4 styles (${color:1})..."
        compile_sass "${SRC_DIR}/main/gtk-4.0/gtk${color}.scss"  "${THEME_DIR}/gtk-4.0/gtk.css"

        if [[ "${color}" == "" ]]; then
            update_progress "Compiling GTK4 Dark variants..."
            compile_sass "${SRC_DIR}/main/gtk-4.0/gtk-Dark.scss"     "${THEME_DIR}/gtk-4.0/gtk-dark.css"
        else
            update_progress "Linking GTK4 Dark variants..."
            run_safe ln -s "gtk.css" "${THEME_DIR}/gtk-4.0/gtk-dark.css"
        fi
    fi
}

# Links installed GTK4 theme variant assets to ~/.config/gtk-4.0 for Libadwaita.
# Args:
#   1: dest       - Base destination path
#   2: name       - Theme name prefix
#   3: theme      - Accent variant suffix
#   4: color      - Color scheme mode suffix
#   5: size       - Size variant suffix
#   6: ctype      - Background scheme suffix
#   7: tweaks_tag - Tweaks tag suffix
link_libadwaita() {
    local dest="${1}"
    local name="${2}"
    local theme="${3}"
    local color="${4}"
    local size="${5}"
    local ctype="${6}"
    local tweaks_tag="${7:-}"

    local THEME_DIR="${dest}/${name}${ctype}${theme}${color}${size}${tweaks_tag}"

    local display_theme_dir=$(get_display_path "$THEME_DIR")
    local display_config_dir="~/.config/gtk-4.0"

    # Log linking info
    printf "\r\033[K│ %-27s : '%s'\n" \
        "Linking Libadwaita  to path" "${display_config_dir}"

    # Clean up old configuration links
    run_safe mkdir -p "${HOME}/.config/gtk-4.0"
    run_safe rm -rf "${HOME}/.config/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"

    # Create symlinks to the installed GTK4 files
    run_safe ln -sf "${THEME_DIR}/gtk-4.0/assets"       "${HOME}/.config/gtk-4.0/assets"
    run_safe ln -sf "${THEME_DIR}/gtk-4.0/gtk.css"      "${HOME}/.config/gtk-4.0/gtk.css"
    run_safe ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"
}

# Iterates and links Libadwaita settings for all selected variants.
link_themes() {
    for theme in "${themes[@]}"; do
        for color in "${lcolors[@]}"; do
            for size in "${sizes[@]}"; do
                link_libadwaita "${dest:-$DEST_DIR}" "${name:-$THEME_NAME}" "$theme" "$color" "$size" "$ctype" "$tweaks_tag"
            done
        done
    done
}
