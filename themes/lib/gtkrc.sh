#!/usr/bin/env bash

# Catppuccin GTK Theme: GTK2 Config Generator
# Generates and patches the GTK2 gtkrc configuration file with selected variant colors.
# Author: @fkorpsvart | License: GPL-3.0

# --- Lookup Tables Definition ---
# Note: 'default' and 'none' sentinel keys are used because Bash arrays cannot have empty keys.
declare -A PALETTE_LIGHT
declare -A PALETTE_DARK
declare -A BACKGROUNDS

# --- Light Latte Accent Palette Colors ---
PALETTE_LIGHT["default"]="#006A83"
PALETTE_LIGHT["-Blue"]="#1E66F5"
PALETTE_LIGHT["-Flamingo"]="#DD7878"
PALETTE_LIGHT["-Green"]="#40A02B"
PALETTE_LIGHT["-Grey"]="#6C7086"
PALETTE_LIGHT["-Lavender"]="#7287FD"
PALETTE_LIGHT["-Maroon"]="#E64553"
PALETTE_LIGHT["-Mauve"]="#8839EF"
PALETTE_LIGHT["-Peach"]="#FE640B"
PALETTE_LIGHT["-Pink"]="#EA76CB"
PALETTE_LIGHT["-Red"]="#D20F39"
PALETTE_LIGHT["-Rosewater"]="#DC8A78"
PALETTE_LIGHT["-Sapphire"]="#209FB5"
PALETTE_LIGHT["-Sky"]="#04A5E5"
PALETTE_LIGHT["-Teal"]="#179299"
PALETTE_LIGHT["-Yellow"]="#DF8E1D"

# --- Dark Mocha Accent Palette Colors ---
PALETTE_DARK["default"]="#27A1B9"
PALETTE_DARK["-Blue"]="#89B4FA"
PALETTE_DARK["-Flamingo"]="#F2CDCD"
PALETTE_DARK["-Green"]="#A6E3A1"
PALETTE_DARK["-Grey"]="#6C7086"
PALETTE_DARK["-Lavender"]="#B4BEFE"
PALETTE_DARK["-Maroon"]="#EBA0AC"
PALETTE_DARK["-Mauve"]="#CBA6F7"
PALETTE_DARK["-Peach"]="#FAB387"
PALETTE_DARK["-Pink"]="#F5C2E7"
PALETTE_DARK["-Red"]="#F38BA8"
PALETTE_DARK["-Rosewater"]="#F5E0DC"
PALETTE_DARK["-Sapphire"]="#74C7EC"
PALETTE_DARK["-Sky"]="#89DCEB"
PALETTE_DARK["-Teal"]="#94E2D5"
PALETTE_DARK["-Yellow"]="#F9E2AF"

# --- Dark Frappé Accent Palette Colors ---
PALETTE_DARK["default"]="#29A4BD"
PALETTE_DARK["-Blue"]="#8CAAEE"
PALETTE_DARK["-Flamingo"]="#EEBEBE"
PALETTE_DARK["-Green"]="#A6D189"
PALETTE_DARK["-Grey"]="#6C7086"
PALETTE_DARK["-Lavender"]="#BABBF1"
PALETTE_DARK["-Maroon"]="#EA999C"
PALETTE_DARK["-Mauve"]="#CA9EE6"
PALETTE_DARK["-Peach"]="#EF9F76"
PALETTE_DARK["-Pink"]="#F4B8E4"
PALETTE_DARK["-Red"]="#E78284"
PALETTE_DARK["-Rosewater"]="#F2D5CF"
PALETTE_DARK["-Sapphire"]="#85C1DC"
PALETTE_DARK["-Sky"]="#99D1DB"
PALETTE_DARK["-Teal"]="#81C8BE"
PALETTE_DARK["-Yellow"]="#E5C890"

# --- Dark Macchiato Accent Palette Colors ---
PALETTE_DARK["default"]="#589ED7"
PALETTE_DARK["-Blue"]="#8AADF4"
PALETTE_DARK["-Flamingo"]="#F0C6C6"
PALETTE_DARK["-Green"]="#A6DA95"
PALETTE_DARK["-Grey"]="#6C7086"
PALETTE_DARK["-Lavender"]="#B7BDF8"
PALETTE_DARK["-Maroon"]="#EE99A0"
PALETTE_DARK["-Mauve"]="#C6A0F6"
PALETTE_DARK["-Peach"]="#F5A97F"
PALETTE_DARK["-Pink"]="#F5BDE6"
PALETTE_DARK["-Red"]="#ED8796"
PALETTE_DARK["-Rosewater"]="#F4DBD6"
PALETTE_DARK["-Sapphire"]="#7DC4E4"
PALETTE_DARK["-Sky"]="#91D7E3"
PALETTE_DARK["-Teal"]="#8BD5CA"
PALETTE_DARK["-Yellow"]="#EED49F"


# --- Background Shade Roles ---
# Key pattern: [ctype]-[blackness_flag]-[shade_role]

# Default Mocha/Latte scheme (standard bg)
BACKGROUNDS["none-FALSE-light"]="#EFF1F5"
BACKGROUNDS["none-FALSE-dark"]="#1E1E2E"
BACKGROUNDS["none-FALSE-darker"]="#11111B"
BACKGROUNDS["none-FALSE-alt"]="#24273A"

# Frappé scheme (standard bg)
BACKGROUNDS["-Frappe-FALSE-light"]="#EFF1F5"
BACKGROUNDS["-Frappe-FALSE-dark"]="#303446"
BACKGROUNDS["-Frappe-FALSE-darker"]="#11111B"
BACKGROUNDS["-Frappe-FALSE-alt"]="#313244"

# Macchiato scheme (standard bg)
BACKGROUNDS["-Macchiato-FALSE-light"]="#EFF1F5"
BACKGROUNDS["-Macchiato-FALSE-dark"]="#24273A"
BACKGROUNDS["-Macchiato-FALSE-darker"]="#11111B"
BACKGROUNDS["-Macchiato-FALSE-alt"]="#292C3C"

# OLED Black overrides
BACKGROUNDS["none-TRUE-dark"]="#010101"
BACKGROUNDS["none-TRUE-darker"]="#000000"
BACKGROUNDS["none-TRUE-alt"]="#020202"

# Frappé scheme (blackness bg)
BACKGROUNDS["-Frappe-TRUE-dark"]="#010101"
BACKGROUNDS["-Frappe-TRUE-darker"]="#000000"
BACKGROUNDS["-Frappe-TRUE-alt"]="#020202"

# Macchiato scheme (blackness bg)
BACKGROUNDS["-Macchiato-TRUE-dark"]="#010101"
BACKGROUNDS["-Macchiato-TRUE-darker"]="#000000"
BACKGROUNDS["-Macchiato-TRUE-alt"]="#020202"

# Builds and injects the customized GTK2 gtkrc stylesheet.
# Args:
#   1: dest       - Base destination path
#   2: name       - Theme name prefix
#   3: theme      - Accent variant suffix
#   4: color      - Color scheme suffix
#   5: size       - Size suffix
#   6: ctype      - Background scheme suffix
#   7: window     - Button layout suffix
#   8: tweaks_tag - Tweaks tag suffix
make_gtkrc() {
    local dest="${1}"
    local name="${2}"
    local theme="${3:-default}"
    local color="${4}"
    local size="${5}"
    local ctype="${6:-none}"
    local window="${7}"
    local tweaks_tag="${8:-}"

    # Normalise empty parameters into sentinel keys
    [[ -z "${theme}" ]] && theme="default"
    [[ -z "${ctype}" ]] && ctype="none"

    local ELSE_DARK=""
    [[ "${color}" == '-Dark' ]] && ELSE_DARK="${color}"

    local GTKRC_DIR="${SRC_DIR}/main/gtk-2.0"
    local THEME_DIR="${1}/${2}${6}${3}${4}${5}${tweaks_tag}"

    # Resolve accent color
    local theme_color
    local lookup_key="${ctype}${theme}"
    [[ "${ctype}" == "none" ]] && lookup_key="${theme}"

    if [[ "${color}" == '-Dark' ]]; then
        theme_color="${PALETTE_DARK[$lookup_key]:-${PALETTE_DARK[$theme]:-}}"
    else
        theme_color="${PALETTE_LIGHT[$lookup_key]:-${PALETTE_LIGHT[$theme]:-}}"
    fi

    # Resolve background shades
    local is_black="${blackness:-false}"
    is_black="${is_black^^}"

    local bg_key_prefix="${ctype}-${is_black}"
    local bg_light="${BACKGROUNDS[${ctype}-FALSE-light]:-${BACKGROUNDS[none-FALSE-light]:-#EFF1F5}}"
    local bg_dark="${BACKGROUNDS[${bg_key_prefix}-dark]:-${BACKGROUNDS[none-${is_black}-dark]:-#1E1E2E}}"
    local bg_darker="${BACKGROUNDS[${bg_key_prefix}-darker]:-${BACKGROUNDS[none-${is_black}-darker]:-#11111B}}"
    local bg_alt="${BACKGROUNDS[${bg_key_prefix}-alt]:-${BACKGROUNDS[none-${is_black}-alt]:-#232634}}"

    local titlebar_light="${bg_light}"
    local titlebar_dark="${bg_dark}"

    # Deploy and patch gtkrc template
    run_safe mkdir -p "${THEME_DIR}/gtk-2.0"
    run_safe cp -r "${GTKRC_DIR}/gtkrc${ELSE_DARK}-default" "${THEME_DIR}/gtk-2.0/gtkrc"

    # Substitute placeholder colors with resolved theme colors
    if [[ "${color}" == '-Dark' ]]; then
        run_safe sed -i "s/#27A1B9/${theme_color}/g"    "${THEME_DIR}/gtk-2.0/gtkrc"
        run_safe sed -i "s/#EFF1F5/${bg_light}/g"       "${THEME_DIR}/gtk-2.0/gtkrc"
        run_safe sed -i "s/#1E1E2E/${bg_dark}/g"        "${THEME_DIR}/gtk-2.0/gtkrc"
        run_safe sed -i "s/#11111B/${bg_alt}/g"         "${THEME_DIR}/gtk-2.0/gtkrc"
        run_safe sed -i "s/#010101/${bg_darker}/g"      "${THEME_DIR}/gtk-2.0/gtkrc"
        run_safe sed -i "s/#1E1E2E/${titlebar_dark}/g"  "${THEME_DIR}/gtk-2.0/gtkrc"
    else
        run_safe sed -i "s/#006A83/${theme_color}/g"    "${THEME_DIR}/gtk-2.0/gtkrc"
        run_safe sed -i "s/#EFF1F5/${titlebar_light}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
    fi
}
