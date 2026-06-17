#!/usr/bin/env bash

# Catppuccin GTK Theme: Uninstaller
# Provides functions to safely remove theme directories and configuration links.
# Author: @fkorpsvart | License: GPL-3.0

# Removes GTK4/Libadwaita config symlinks from ~/.config/gtk-4.0.
uninstall_link() {
    run_safe rm -rf \
        "${HOME}/.config/gtk-4.0/assets"        \
        "${HOME}/.config/gtk-4.0/windows-assets" \
        "${HOME}/.config/gtk-4.0/gtk.css"        \
        "${HOME}/.config/gtk-4.0/gtk-dark.css"
}

# Removes a single theme variant directory if it exists.
# Args:
#   1: dest  - Base destination path
#   2: name  - Theme base name
#   3: theme - Accent color suffix
#   4: color - Color scheme suffix
#   5: size  - Size variant suffix
#   6: ctype - Background scheme suffix
uninstall_theme_folder() {
    local dest="${1}"
    local name="${2}"
    local theme="${3}"
    local color="${4}"
    local size="${5}"
    local ctype="${6}"

    local THEME_DIR="${dest}/${name}${ctype}${theme}${color}${size}"

    if [[ -d "${THEME_DIR}" ]]; then
        # Normalise path for console logs
        local display_dir=$(get_display_path "${THEME_DIR}")
        log_info "Uninstalling ${COLOR_BOLD}${display_dir}${COLOR_RESET}... "
        run_safe rm -rf "${THEME_DIR}"
    fi
}

# Iterates and removes all selected theme variant folders.
uninstall_themes() {
    log_info "Uninstalling selected theme variants..."
    for theme in "${themes[@]}"; do
        for color in "${colors[@]}"; do
            for size in "${sizes[@]}"; do
                uninstall_theme_folder "${dest:-$DEST_DIR}" "${name:-$THEME_NAME}" "$theme" "$color" "$size" "$ctype"
            done
        done
    done
}
