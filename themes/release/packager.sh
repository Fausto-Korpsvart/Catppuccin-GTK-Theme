#!/bin/bash

THEME_DIR=$(cd "$(dirname "$0")" && pwd)
THEME_NAME=Catppuccin

_THEME_VARIANTS=('' '-Blue' '-Flamingo' '-Green' '-Grey' '-Lavender' '-Maroon' '-Mauve' '-Peach' '-Pink' '-Red' '-Rosewater' '-Sapphire' '-Sky' '-Teal' '-Yellow')
_SCHEME_VARIANTS=('' '-Frappe' '-Macchiato')
_COLOR_VARIANTS=('-Light' '-Dark')
_SIZE_VARIANTS=('' '-Compact')

if [ ! -z "${COLOR_VARIANTS:-}" ]; then IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"; fi
if [ ! -z "${SCHEME_VARIANTS:-}" ]; then IFS=', ' read -r -a _SCHEME_VARIANTS <<< "${SCHEME_VARIANTS:-}"; fi
if [ ! -z "${THEME_VARIANTS:-}" ]; then  IFS=', ' read -r -a _THEME_VARIANTS <<< "${THEME_VARIANTS:-}"; fi
if [ ! -z "${SIZE_VARIANTS:-}" ]; then   IFS=', ' read -r -a _SIZE_VARIANTS <<< "${SIZE_VARIANTS:-}"; fi

tar_themes() {
    for scheme in "${_SCHEME_VARIANTS[@]}"; do
        rm -f "${THEME_NAME}${scheme}.tar" "${THEME_NAME}${scheme}.tar.xz"
    done

    for scheme in "${_SCHEME_VARIANTS[@]}"; do
        local log_name="${scheme}"
        [[ -z "$log_name" ]] && log_name="Mocha"

        echo "Preparing the package for the scheme: ${log_name}"
        tar_targets=()

        for theme in "${_THEME_VARIANTS[@]}"; do
            for color in "${_COLOR_VARIANTS[@]}"; do
                for size in "${_SIZE_VARIANTS[@]}"; do

                    dir_name="${THEME_NAME}${scheme}${theme}${color}${size}"

                    if [ -d "$dir_name" ]; then
                        tar_targets+=("$dir_name")
                    fi
                done
            done
        done

        if [ ${#tar_targets[@]} -gt 0 ]; then
            echo "Packing ${#tar_targets[@]} variants into ${THEME_NAME}${scheme}.tar.xz..."
            tar -Jcvf "${THEME_NAME}${scheme}.tar.xz" "${tar_targets[@]}"
        else
            echo "Warning: No physical folders were found for the scheme ${log_name}."
        fi
    done
}

clear_theme() {
    echo "Cleaning up temporal source directory variants..."
    for scheme in "${_SCHEME_VARIANTS[@]}"; do
        for theme in "${_THEME_VARIANTS[@]}"; do
            for color in "${_COLOR_VARIANTS[@]}"; do
                for size in "${_SIZE_VARIANTS[@]}"; do
                    rm -rf "${THEME_NAME}${scheme}${theme}${color}${size}"{'','-hdpi','-xhdpi'}
                done
            done
        done
    done
}

THEMES_ROOT_DIR=$(cd "$THEME_DIR/.." && pwd)

echo "Executing theme installer from context: $THEMES_ROOT_DIR"

BATCH_MODE=true "$THEMES_ROOT_DIR/install.sh" -d "$THEME_DIR" -a all
BATCH_MODE=true "$THEMES_ROOT_DIR/install.sh" -d "$THEME_DIR" --tweaks frappe -a all
BATCH_MODE=true "$THEMES_ROOT_DIR/install.sh" -d "$THEME_DIR" --tweaks macchiato -a all

cd "$THEME_DIR"

tar_themes
clear_theme
