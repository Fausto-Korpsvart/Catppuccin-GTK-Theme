#!/usr/bin/env bash

# Catppuccin GTK Theme: SASS Tweaks Manager
# Modifies temporary copies of SASS stylesheets to apply active visual tweaks.
# Author: @fkorpsvart | License: GPL-3.0

# Creates a temporary working copy of the tweaks SASS file.
tweaks_temp() {
    run_safe cp -rf "${SRC_DIR}/sass/_tweaks.scss" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Enables the compact widget size variant in SASS.
compact_size() {
    run_safe sed -i "/\$compact:/s/false/true/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Applies the Frappé background color scheme.
frappe_color() {
    run_safe sed -i "/@import/s/color-palette-default/color-palette-frappe/" "${SRC_DIR}/sass/_tweaks-temp.scss"
    run_safe sed -i "/\$colorscheme:/s/default/frappe/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Applies the Macchiato background color scheme.
macchiato_color() {
    run_safe sed -i "/@import/s/color-palette-default/color-palette-macchiato/" "${SRC_DIR}/sass/_tweaks-temp.scss"
    run_safe sed -i "/\$colorscheme:/s/default/macchiato/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Enables pure black backgrounds for OLED screens.
blackness_color() {
    run_safe sed -i "/\$blackness:/s/false/true/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Enables floating GNOME Shell panel style.
float_panel() {
    run_safe sed -i "/\$float:/s/false/true/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Enables 2px contrasting border style on GTK windows.
border_style() {
    run_safe sed -i "/\$border:/s/false/true/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Configures window controls to macOS style.
macos_winbutton() {
    run_safe sed -i "/\$window_button:/s/normal/mac/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Sets selected accent color name in SASS.
# Args:
#   1: variant_theme - Suffix of selected accent (e.g. -Blue)
theme_color() {
    local t_name="${1:-${theme:-}}"

    if [[ -n "$t_name" ]]; then
        local t_color="${t_name#-}"
        t_color="${t_color,,}"
        SELECTED_ACCENT="${t_color}"
        run_safe sed -i "/\$theme:/s/default/${t_color}/" "${SRC_DIR}/sass/_tweaks-temp.scss"
    fi
}

# Appends custom panel opacity value to SASS.
apply_shell_opacity() {
    if [[ "${shell_opacity}" != "0.85" ]]; then
        run_safe bash -c "echo '\$panel-opacity: ${shell_opacity};' >> '${SRC_DIR}/sass/_tweaks-temp.scss'"
    fi
}

# Enables legacy Nautilus file manager styling.
files_legacy() {
    run_safe sed -i "/\$files_legacy:/s/false/true/" "${SRC_DIR}/sass/_tweaks-temp.scss"
}

# Injects custom border-radius value to SASS.
roundness_radius() {
    if [[ "${roundness}" != "12" ]]; then
        run_safe sed -i "/\$roundness:/s/12/${roundness}/" "${SRC_DIR}/sass/_tweaks-temp.scss"
    fi
}

# Toggles GNOME Shell panel border in SASS.
panel_border_style() {
    if [[ "${panel_border}" == "false" ]]; then
        run_safe sed -i "/\$panel_border:/s/true/false/" "${SRC_DIR}/sass/_tweaks-temp.scss"
    fi
}

# Orchestrates SASS files patching based on active config flags.
# Args:
#   1: mode - Display mode ('report' to show tweaks, 'silent' to skip)
apply_theme_tweaks() {
    local mode="${1:-report}"

    if [[ "${DRY_RUN:-}" != "true" ]]; then
        tweaks_temp

        # Apply selected tweaks to SASS temporary file
        if [[ "${accent:-}" == "true" ]]; then theme_color "${theme:-}" >/dev/null 2>&1; fi
        if [[ "$compact"    == "true" ]]; then compact_size;     fi
        if [[ "$frappe"     == "true" ]]; then frappe_color;     fi
        if [[ "$macchiato"  == "true" ]]; then macchiato_color;  fi
        if [[ "$blackness"  == "true" ]]; then blackness_color;  fi
        if [[ "$float"      == "true" ]]; then float_panel;      fi
        if [[ "$border"     == "true" ]]; then border_style;     fi
        if [[ "$macos"      == "true" ]]; then macos_winbutton;  fi
        if [[ "${files_legacy:-}" == "true" ]]; then files_legacy; fi
        apply_shell_opacity
        roundness_radius
        panel_border_style
    fi

    # Log active modifications to console
    if [[ "$mode" == "report" ]]; then
        log_header "Selected Tweaks"
        report_tweaks "selected"
    fi
}

# Prints details of active theme tweaks to the terminal.
# Args:
#   1: mode - 'selected' (show active only) or 'all' (show all options)
report_tweaks() {
    local mode="${1:-selected}"
    local count=0

    # Accent color
    if [[ "${accent:-}" == "true" ]]; then
        local resolved_accents=()
        for t in "${themes[@]}"; do
            local t_name="${t#-}"
            if [[ -z "${t_name}" ]]; then
                resolved_accents+=("Default")
            else
                resolved_accents+=("${t_name^}")
            fi
        done
        local accent_display
        accent_display=$(IFS=", "; echo "${resolved_accents[*]}")
        printf "\r\033[K│ %-20s : '%s'\n" "Accent color" "${accent_display}"
        count=$((count + 1))
    elif [[ "$mode" == "all" ]]; then
        printf "\r\033[K│ %-20s : '%s'\n" "Accent color" "Default"
        count=$((count + 1))
    fi

    # Background scheme
    if   [[ "$frappe"    == "true" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Theme base color" "Frappe"; count=$((count + 1))
    elif [[ "$macchiato" == "true" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Theme base color" "Macchiato"; count=$((count + 1))
    elif [[ "$blackness" == "true" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Theme base color" "Blackness"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];       then printf "\r\033[K│ %-20s : '%s'\n" "Theme base color" "Default (Default)"; count=$((count + 1))
    fi

    # Window size
    if   [[ "$compact" == "true" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Window size" "Compact"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];     then printf "\r\033[K│ %-20s : '%s'\n" "Window size" "Standard (Default)"; count=$((count + 1))
    fi

    # Window border
    if   [[ "$border" == "true" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Window border" "2px"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];    then printf "\r\033[K│ %-20s : '%s'\n" "Window border" "None (Default)"; count=$((count + 1))
    fi

    # Window control buttons
    if   [[ "$macos" == "true" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Window buttons style" "macOS"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];   then printf "\r\033[K│ %-20s : '%s'\n" "Window buttons style" "Standard (Default)"; count=$((count + 1))
    fi

    # GNOME Shell panel style
    if   [[ "$float" == "true" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Panel Style" "Floating"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];   then printf "\r\033[K│ %-20s : '%s'\n" "Panel Style" "Standard (Default)"; count=$((count + 1))
    fi

    # GNOME Shell panel opacity
    if   [[ "${shell_opacity}" != "0.85" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "GNOME Shell opacity" "${shell_opacity}"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];             then printf "\r\033[K│ %-20s : '%s'\n" "GNOME Shell opacity" "0.85 (Default)"; count=$((count + 1))
    fi

    # Nautilus legacy style
    if [[ "${files_legacy:-}" == "true" ]]; then
        printf "\r\033[K│ %-20s : '%s'\n" "Nautilus Design" "Legacy"
        count=$((count + 1))
    elif [[ "$mode" == "all" ]]; then
        printf "\r\033[K│ %-20s : '%s'\n" "Nautilus Design" "Standard (Default)"
        count=$((count + 1))
    fi

    # Border radius
    if   [[ "${roundness}" != "12" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Border radius" "${roundness}px"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];       then printf "\r\033[K│ %-20s : '%s'\n" "Border radius" "12px (Default)"; count=$((count + 1))
    fi

    # Panel/dock border
    if   [[ "${panel_border}" == "false" ]]; then printf "\r\033[K│ %-20s : '%s'\n" "Panel Border" "None"; count=$((count + 1))
    elif [[ "$mode" == "all" ]];             then printf "\r\033[K│ %-20s : '%s'\n" "Panel Border" "2px (Default)"; count=$((count + 1))
    fi

    # Print the footer
    printf "\r\033[K└ ${COLOR_SUCCESS}%d${COLOR_RESET}${COLOR_GRAY} Tweaks Selected${COLOR_RESET}\n" "${count}"
}
