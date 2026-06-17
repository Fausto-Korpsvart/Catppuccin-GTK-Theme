#!/usr/bin/env bash

# Catppuccin GTK Theme: Installer Orchestrator
# Coordinates the installation and uninstallation of the theme variants.
# Author: @fkorpsvart | License: GPL-3.0

set -euo pipefail
set -o errtrace

# --- Directory Definitions ---
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
SRC_DIR="${REPO_DIR}/src"
LIB_DIR="${REPO_DIR}/lib"

# --- Load Library Modules ---
source "${LIB_DIR}/config.sh"                 # Global configuration and defaults
source "${LIB_DIR}/utils.sh"                  # Logging, UI utilities, and system detection
source "${LIB_DIR}/gtkrc.sh"                  # GTK2 configuration builder
source "${LIB_DIR}/tweaks.sh"                 # SASS tweaks manager
source "${LIB_DIR}/parser.sh"                 # CLI arguments parser
source "${LIB_DIR}/uninstall.sh"              # Theme removal functions
source "${LIB_DIR}/installers/gnome_shell.sh" # GNOME Shell installer
source "${LIB_DIR}/installers/gtk.sh"         # GTK2/3/4 installer
source "${LIB_DIR}/installers/desktop_env.sh" # Cinnamon, Metacity, XFWM4 installer

# --- Trap Handlers ---
trap cleanup EXIT
trap 'shell_error_handler $LINENO "$BASH_COMMAND"' ERR

# Deploys a single theme variant configuration to the destination.
# Args:
#   1: dest       - Base destination path
#   2: name       - Theme name prefix
#   3: theme      - Accent variant suffix
#   4: color      - Color scheme suffix (-Light/-Dark)
#   5: size       - Window control size suffix (-Compact)
#   6: ctype      - Background tweak suffix (-Frappé/-Macchiato)
#   7: window     - Button layout suffix (-Macos)
#   8: tweaks_tag - Active tweaks tag combination
install_theme_variant() {
    local dest="${1}"
    local name="${2}"
    local theme="${3}"
    local color="${4}"
    local size="${5}"
    local ctype="${6}"
    local window="${7}"
    local tweaks_tag="${8:-}"

    local ELSE_DARK=""
    [[ "${color}" == "-Dark" ]] && ELSE_DARK="${color}"

    local THEME_DIR="${dest}/${name}${ctype}${theme}${color}${size}${tweaks_tag}"

    apply_theme_tweaks "silent"

    if [[ -d "${THEME_DIR}" ]]; then
        run_safe rm -rf "${THEME_DIR}"
    fi

    local display_dir=$(get_display_path "${THEME_DIR}")

    log_debug "Installing variant to: ${display_dir}"
    run_safe mkdir -p "${THEME_DIR}"

    # Generate the index.theme file for desktop environments.
    if [[ "${DRY_RUN:-}" != "true" ]]; then
        cat <<EOF >> "${THEME_DIR}/index.theme"
[Desktop Entry]
Type=X-GNOME-Metatheme
Name=${name}${ctype}${theme}${color}${size}
Comment=A Flat Gtk+ theme based on Elegant Design
Encoding=UTF-8

[X-GNOME-Metatheme]
GtkTheme=${name}${ctype}${theme}${color}${size}
MetacityTheme=${name}${ctype}${theme}${color}${size}
IconTheme=Tela-circle${ELSE_DARK:-}
CursorTheme=${name}-cursors
ButtonLayout=close,minimize,maximize:menu
EOF
    else
        log_debug "${COLOR_GRAY}[SIMULATION SKIP]${COLOR_RESET} Generating index.theme in ${THEME_DIR}/index.theme"
    fi

    # Delegate to component-specific installers
    install_gnome_shell "${THEME_DIR}" "${color}" "${theme}" "${ctype}"
    install_gtk         "${THEME_DIR}" "${color}" "${theme}" "${ctype}"
    install_desktop_env "${THEME_DIR}" "${color}" "${theme}" "${ctype}" "${window}"
}

# Iterates and installs all selected variants.
run_installation() {
    local total_variants=$((${#themes[@]} * ${#colors[@]} * ${#sizes[@]}))
    local current_variant=0

    for theme in "${themes[@]}"; do
        for color in "${colors[@]}"; do
            for size in "${sizes[@]}"; do
                GLOBAL_TOTAL_STEPS=$STEPS_PER_VARIANT
                GLOBAL_CURRENT_STEP=0
                current_variant=$((current_variant + 1))

                local color_label="Light Version"
                local color_icon="${COLOR_WARN}${COLOR_RESET}"
                if [[ "${color}" == "-Dark" ]]; then
                    color_label="Dark Version"
                    color_icon="${COLOR_VIOLET}${COLOR_RESET}"
                fi
                log_info "${color_icon} ${color_label}"

                install_theme_variant "${dest:-$DEST_DIR}" "${name:-$THEME_NAME}" "$theme" "$color" "$size" "$ctype" "$window" "$tweaks_tag"
                make_gtkrc            "${dest:-$DEST_DIR}" "${name:-$THEME_NAME}" "$theme" "$color" "$size" "$ctype" "$window" "$tweaks_tag"

                progress_bar "${GLOBAL_TOTAL_STEPS}" "${GLOBAL_TOTAL_STEPS}" "Finalising variant..."
                log_success "Done: ${name:-$THEME_NAME}${ctype}${theme}${color}${size}${tweaks_tag}"

                if [[ $current_variant -lt $total_variants ]]; then
                    log_info ""
                else
                    echo
                fi
            done
        done
    done

    if [[ "${BATCH_MODE:-}" == "true" ]]; then
        log_info "Batch mode detected: skipping interactive menu."
        MENU_RESULT=1
    else
        MENU_NOTE="You will manually apply the theme as explained in the documentation"
        interactive_menu "Do you want to apply Vague?" "Yes : Automatic installation" "No  : Manual installation"
    fi

    if [[ $MENU_RESULT -eq 0 ]]; then
        # Reset MENU_NOTE since it's not needed for the next menu
        MENU_NOTE=""
        interactive_menu "Which variant do you want to apply?" "Light : Set all themes to Light" "Dark  : Set all themes to Dark"

        local apply_color="-Dark"
        [[ $MENU_RESULT -eq 0 ]] && apply_color="-Light"

        log_header "Session Integration"

        apply_theme_settings "${name:-$THEME_NAME}" "$theme" "$apply_color" "$size" "$ctype" "$tweaks_tag"

        if [[ "${libadwaita:-}" == 'true' ]]; then
            uninstall_link
            link_libadwaita "${dest:-$DEST_DIR}" "${name:-$THEME_NAME}" "$theme" "$apply_color" "$size" "$ctype" "$tweaks_tag"
        fi

        log_success "Integration of ${name:-$THEME_NAME}${ctype}${theme}${apply_color}${size}${tweaks_tag} Theme"

        # Store details for post-install summary.
        APPLIED_THEME="${name:-$THEME_NAME}${ctype}${theme}${apply_color}${size}${tweaks_tag}"
        if [[ "$apply_color" == "-Dark" ]]; then
            APPLIED_SCHEME="Dark Mode"
        else
            APPLIED_SCHEME="Light Mode"
        fi
    else
        log_info "Skipping automatic theme application."
    fi

    # XFCE adjustments (transparency and panel reload)
    if has_command xfce4-popup-whiskermen; then
        run_safe sed -i "s|.*menu-opacity=.*|menu-opacity=0|" "$HOME/.config/xfce4/panel/whiskermenu"*".rc"
    fi
    if pgrep xfce4-session &>/dev/null; then
        run_safe xfce4-panel -r
    fi
}

# Applies the theme configurations to the active desktop environment session.
# Args:
#   1: name       - Theme name prefix
#   2: theme      - Accent variant suffix
#   3: color      - Color scheme suffix
#   4: size       - Size suffix
#   5: ctype      - Background scheme suffix
#   6: tweaks_tag - Tweaks tag suffix
apply_theme_settings() {
    local name="${1}"
    local theme="${2}"
    local color="${3}"
    local size="${4}"
    local ctype="${5}"
    local tweaks_tag="${6:-}"

    local THEME_FULL_NAME="${name}${ctype}${theme}${color}${size}${tweaks_tag}"
    local display_dest=$(echo "${dest:-$DEST_DIR}" | sed "s|^$HOME|~|")

    local scheme_label="Dark Mode"
    [[ "${color}" != '-Dark' ]] && scheme_label="Light Mode"

    # Print colorscheme setting line
    printf "\r\033[K│ %-27s : '%s'\n" "Setting colorscheme to mode" "${scheme_label}"

    # 1. Apply color scheme preference (GNOME / Cinnamon / general)
    if has_command gsettings; then
        if gsettings list-schemas | grep -q "org.gnome.desktop.interface"; then
            if [[ "${color}" == '-Dark' ]]; then
                run_safe gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
            else
                run_safe gsettings set org.gnome.desktop.interface color-scheme "default"
            fi
        fi
    fi

    # 2. Apply DE-specific settings
    local is_gnome=false
    local is_cinnamon=false
    local is_mate=false
    local is_xfce=false

    # Check via XDG_CURRENT_DESKTOP or available schemas/commands
    local desktop="${XDG_CURRENT_DESKTOP:-}"
    desktop="${desktop,,}"

    if [[ "${desktop}" == *"cinnamon"* ]] || (has_command gsettings && gsettings list-schemas | grep -q "org.cinnamon.desktop.interface"); then
        is_cinnamon=true
    elif [[ "${desktop}" == *"mate"* ]] || (has_command gsettings && gsettings list-schemas | grep -q "org.mate.interface"); then
        is_mate=true
    elif [[ "${desktop}" == *"xfce"* ]] || has_command xfconf-query; then
        is_xfce=true
    else
        is_gnome=true # Default fallback to GNOME
    fi

    if [[ "${is_gnome}" == "true" ]]; then
        # GNOME Session Integration
        printf "\r\033[K│ %-27s : '%s'\n" "Setting Shell theme to path" "${display_dest}/${THEME_FULL_NAME}/gnome-shell"
        if has_command gsettings; then
            if gsettings list-schemas | grep -q "org.gnome.shell.extensions.user-theme"; then
                run_safe gsettings set org.gnome.shell.extensions.user-theme name ""
                sleep 0.2
                run_safe gsettings set org.gnome.shell.extensions.user-theme name "${THEME_FULL_NAME}"
            elif has_command dconf; then
                run_safe dconf write /org/gnome/shell/extensions/user-theme/name "''"
                sleep 0.2
                run_safe dconf write /org/gnome/shell/extensions/user-theme/name "'${THEME_FULL_NAME}'"
            fi
            run_safe gsettings set org.gnome.desktop.interface gtk-theme "${THEME_FULL_NAME}"
        fi
    elif [[ "${is_cinnamon}" == "true" ]]; then
        # Cinnamon Session Integration
        printf "\r\033[K│ %-27s : '%s'\n" "Setting Shell theme to path" "${display_dest}/${THEME_FULL_NAME}/cinnamon"
        if has_command gsettings; then
            run_safe gsettings set org.cinnamon.desktop.interface gtk-theme "${THEME_FULL_NAME}"
            run_safe gsettings set org.cinnamon.theme name "${THEME_FULL_NAME}"
            run_safe gsettings set org.cinnamon.desktop.wm.preferences theme "${THEME_FULL_NAME}"
        fi
    elif [[ "${is_mate}" == "true" ]]; then
        # MATE Session Integration
        printf "\r\033[K│ %-27s : '%s'\n" "Setting Marco theme to path" "${display_dest}/${THEME_FULL_NAME}/metacity-1"
        if has_command gsettings; then
            run_safe gsettings set org.mate.interface gtk-theme "${THEME_FULL_NAME}"
            run_safe gsettings set org.mate.Marco.general theme "${THEME_FULL_NAME}"
        fi
    elif [[ "${is_xfce}" == "true" ]]; then
        # XFCE Session Integration
        printf "\r\033[K│ %-27s : '%s'\n" "Setting XFWM4 theme to path" "${display_dest}/${THEME_FULL_NAME}/xfwm4"
        if has_command xfconf-query; then
            run_safe xfconf-query -c xsettings -p /Net/ThemeName -s "${THEME_FULL_NAME}"
            run_safe xfconf-query -c xfwm4 -p /general/theme -s "${THEME_FULL_NAME}"
        fi
    fi

    # Print GTK-3 and GTK-4 lines
    printf "\r\033[K│ %-27s : '%s'\n" "Setting GTK-3 theme to path" "${display_dest}/${THEME_FULL_NAME}/gtk-3.0"
    printf "\r\033[K│ %-27s : '%s'\n" "Setting GTK-4 theme to path" "${display_dest}/${THEME_FULL_NAME}/gtk-4.0"
}

# Main execution entry point.
main() {
    parse_args "$@"
    print_banner

    if [[ "${uninstall:-}" == 'true' ]]; then
        log_header "UNINSTALLATION"
        if [[ "${libadwaita:-}" == 'true' ]]; then
            log_info "Uninstalling ~/.config/gtk-4.0 links..."
            uninstall_link
        else
            uninstall_themes && uninstall_link
        fi
    else
        log_header "System Verification"
        install_package
        detect_gs_version
        detect_gtk_versions
        log_debug "Detected Shell v${SHELL_FULL_VERSION}"
        log_debug "Detected GTK-3 v${GTK3_VERSION}"
        log_debug "Detected GTK-4 v${GTK4_VERSION}"

        apply_theme_tweaks

        log_header "Compilation & Installations"
        log_info "Compiling SASS sources..."
        PROGRESS_ICON="󰣖"
        for i in {1..10}; do
            progress_bar $((i * 10)) 100 "Compiling..."
            sleep 0.05
        done
        echo
        log_info ""

        STEPS_PER_VARIANT=13

        if [[ "${DRY_RUN:-}" != "true" ]]; then
            log_debug "Patching SASS sources..."
            patch_gnome_shell_sass
        fi

        run_installation
        print_summary
    fi
}

main "$@"

echo
