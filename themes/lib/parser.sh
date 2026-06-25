#!/usr/bin/env bash

# Catppuccin GTK Theme: CLI Parser
# Parses CLI arguments, initializes configuration defaults, and compiles tweak tags.
# Author: @fkorpsvart | License: GPL-3.0

# Prints command-line usage information.
usage() {
    cat <<EOF
Usage: $0 [OPTION]...

OPTIONS:
  -d, --dest DIR          Specify destination directory (Default: $DEST_DIR)

  -n, --name NAME         Specify theme name (Default: $THEME_NAME)

  -a, --accent VARIANT    Specify theme accent variant(s) [default|blue|flamingo|green|grey|lavender|maroon|mauve|peach|pink|red|rosewater|sapphire|sky|teal|yellow|all] (Default: accent)

  -m, --mode VARIANT      Specify theme mode variant(s) [light|dark] (Default: All variants)

  -s, --size VARIANT      Specify size variant [standard|compact] (Default: standard variant)

  -l, --libadwaita        Link installed GTK4 theme to config folder for Libadwaita applications

  -v, --verbose           Display detailed installation logs

  -S, --dry-run           Simulate installation without making changes

  -r, --remove,
  -u, --uninstall         Uninstall/Remove installed themes or links

  --shell                 Specify versions for GNOME Shell tweaks:
                           1. float         Floating GNOME Shell panel style
                           2. opacity       Set panel and dock opacity (0.0 to 1.0)
                           3. radius        Set custom border radius (0 to 32)
                           4. no-border     Remove panel and dock border (for float)

  --tweaks                Specify versions for GTK application tweaks:
                           1. [frappe|macchiato] Colour scheme versions
                           2. black         Pure black background version
                           3. border        Windows with 2px border style
                           4. macos         macOS-style window buttons
                           5. radius        Set custom border radius (0 to 32)
                           6. files-legacy  Nautilus classic legacy style

  -h, --help              Show this help message
EOF
}

# Parses CLI arguments to populate runtime configuration state.
# Args:
#   $@: Arguments list passed to the script
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "${1}" in

                # Destination path override
            -d | --dest)
                dest="${2}"
                if [[ ! -d "${dest}" ]]; then
                    log_info "Destination directory does not exist. Creating: ${dest}"
                    mkdir -p "${dest}"
                fi
                shift 2
                ;;

                # Theme name override
            -n | --name)
                name="${2}"
                shift 2
                ;;

                # Simulation mode (dry-run)
            -S | --dry-run)
                DRY_RUN="true"
                shift
                ;;

                # Verbose mode
            -v | --verbose)
                VERBOSE="true"
                shift
                ;;

                # Uninstall flag
            -r | --remove | -u | --uninstall)
                uninstall="true"
                shift
                ;;

                # Link to Libadwaita
            -l | --libadwaita)
                libadwaita="true"
                shift
                ;;

                # Theme mode variant (Light/Dark)
            -m | --mode | --color)
                shift
                for variant in "${@}"; do
                    case "${variant}" in
                        light)
                            colors+=("${COLOR_VARIANTS[0]}")
                            lcolors+=("${COLOR_VARIANTS[0]}")
                            shift
                            ;;
                        dark)
                            colors+=("${COLOR_VARIANTS[1]}")
                            lcolors+=("${COLOR_VARIANTS[1]}")
                            shift
                            ;;
                        -* | --*)
                            break
                            ;;
                        *)
                            log_error "Unrecognised colour variant: ${variant}"
                            usage
                            exit 1
                            ;;
                    esac
                done
                ;;

                # Accent color variant
            -a | --theme)
                accent='true'
                shift
                for variant in "$@"; do
                    case "$variant" in
                        default)   themes+=("${THEME_VARIANTS[0]}"); shift ;;
                        blue)      themes+=("${THEME_VARIANTS[1]}"); shift ;;
                        flamingo)  themes+=("${THEME_VARIANTS[2]}"); shift ;;
                        green)     themes+=("${THEME_VARIANTS[3]}"); shift ;;
                        grey)      themes+=("${THEME_VARIANTS[4]}"); shift ;;
                        lavender)  themes+=("${THEME_VARIANTS[5]}"); shift ;;
                        maroon)    themes+=("${THEME_VARIANTS[6]}"); shift ;;
                        mauve)     themes+=("${THEME_VARIANTS[7]}"); shift ;;
                        peach)     themes+=("${THEME_VARIANTS[8]}"); shift ;;
                        pink)      themes+=("${THEME_VARIANTS[9]}"); shift ;;
                        red)       themes+=("${THEME_VARIANTS[10]}"); shift ;;
                        rosewater) themes+=("${THEME_VARIANTS[11]}"); shift ;;
                        sapphire)  themes+=("${THEME_VARIANTS[12]}"); shift ;;
                        sky)	   themes+=("${THEME_VARIANTS[13]}"); shift ;;
                        teal)      themes+=("${THEME_VARIANTS[14]}"); shift ;;
                        yellow)    themes+=("${THEME_VARIANTS[15]}"); shift ;;
                        all)       themes+=("${THEME_VARIANTS[@]}"); shift ;;
                        -*)      break ;;
                        *)
                            log_error "Unrecognised theme variant: ${variant}"
                            usage
                            exit 1
                            ;;
                    esac
                done
                ;;

                # Window size variant (Standard/Compact)
            -s | --size)
                shift
                for variant in "$@"; do
                    case "$variant" in
                        standard)
                            sizes+=("${SIZE_VARIANTS[0]}")
                            shift
                            ;;
                        compact)
                            sizes+=("${SIZE_VARIANTS[1]}")
                            compact='true'
                            shift
                            ;;
                        -*)
                            break
                            ;;
                        *)
                            log_error "Unrecognised size variant: ${variant}"
                            usage
                            exit 1
                            ;;
                    esac
                done
                ;;

                # GNOME Shell tweaks
            --shell)
                shift
                while [[ $# -gt 0 ]]; do
                    case "${1}" in
                        float)     float="true"; shift ;;

                        no-border) panel_border="false"; shift ;;

                        opacity)
                            shell_opacity="${2}"
                            if [[ ! "${shell_opacity}" =~ ^(0(\.[0-9]+)?|1(\.0+)?)$ ]]; then
                                log_error "Shell opacity must be between 0.0 and 1.0: ${shell_opacity}"
                                exit 1
                            fi
                            shift 2
                            ;;

                        radius)
                            roundness="${2}"
                            if [[ ! "${roundness}" =~ ^[0-9]+$ || "${roundness}" -lt 0 || "${roundness}" -gt 32 ]]; then
                                log_error "Radius must be a number between 0 and 32: ${roundness}"
                                exit 1
                            fi
                            shift 2
                            ;;

                        -*) break ;;

                        *)
                            log_error "Unrecognised shell tweak: ${1}"
                            usage
                            exit 1
                            ;;
                    esac
                done
                ;;

                # GTK application tweaks
            --tweaks)
                shift
                while [[ $# -gt 0 ]]; do
                    case "${1}" in
                        frappe) frappe="true"; ctype="-Frappe"; shift ;;
                        macchiato) macchiato="true"; ctype="-Macchiato";   shift ;;
                        black) blackness="true"; shift ;;
                        border) border="true"; shift ;;

                        macos)
                            macos="true"
                            window="-Macos"
                            shift
                            ;;

                        radius)
                            roundness="${2}"
                            if [[ ! "${roundness}" =~ ^[0-9]+$ || "${roundness}" -lt 0 || "${roundness}" -gt 32 ]]; then
                                log_error "Radius must be a number between 0 and 32: ${roundness}"
                                exit 1
                            fi
                            shift 2
                            ;;

                        files-legacy) files_legacy="true"; shift ;;

                        -*) break ;;

                        *)
                            log_error "Unrecognised tweak variant: ${1}"
                            usage
                            exit 1
                            ;;
                    esac
                done
                ;;

                # Help
            -h | --help)
                usage
                exit 0
                ;;

                # Unrecognized option
            *)
                log_error "Unrecognised option: ${1}"
                usage
                exit 1
                ;;

        esac
    done

    # Resolve default selections if none were specified
    if [[ "${#themes[@]}" -eq 0 ]]; then
        themes=("${THEME_VARIANTS[0]}")
    fi

    if [[ "${#colors[@]}" -eq 0 ]]; then
        colors=("${COLOR_VARIANTS[@]}")
    fi

    if [[ "${#lcolors[@]}" -eq 0 ]]; then
        lcolors=("${COLOR_VARIANTS[1]}")
    fi

    if [[ "${#sizes[@]}" -eq 0 ]]; then
        sizes=("${SIZE_VARIANTS[0]}")
    fi

    build_tweaks_tag
}

# Compiles active tweaks into a canonical hyphen-separated suffix tag (e.g. -F-BK).
build_tweaks_tag() {
    local parts=()

    # Float / Border group
    if [[ "${float}" == "true" && "${border}" == "true" ]]; then
        parts+=("FB")
    elif [[ "${float}" == "true" ]]; then
        parts+=("F")
    elif [[ "${border}" == "true" ]]; then
        parts+=("B")
    fi

    # Canonical order of additional tweaks
    [[ "${blackness}"           == "true" ]] && parts+=("BK")
    [[ "${macos}"               == "true" ]] && parts+=("MB")
    [[ "${legacy_buttons:-}"    == "true" ]] && parts+=("LB")

    # Build final suffix tag
    if [[ ${#parts[@]} -gt 0 ]]; then
        local joined
        joined=$(IFS="-"; echo "${parts[*]}")
        tweaks_tag="-${joined}"
    fi
}
