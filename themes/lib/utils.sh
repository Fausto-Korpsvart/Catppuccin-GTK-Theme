#!/usr/bin/env bash

# Catppuccin GTK Theme: Installer Utilities
# Core helper functions for UI, logging, dependency check, and system detection.
# Author: @fkorpsvart | License: GPL-3.0

# --- ANSI Colors (Catppuccin Palette) ---
COLOR_RESET="\033[0m"
COLOR_INFO="\033[38;5;67m"
COLOR_SUCCESS="\033[38;5;108m"
COLOR_WARN="\033[38;5;173m"
COLOR_ERROR="\033[38;5;131m"
COLOR_GRAY="\033[38;5;102m"
COLOR_BOLD="\033[38;5;253m"
COLOR_CYAN="\033[38;5;109m"
COLOR_VIOLET="\033[38;5;60m"

# --- UI Console Symbols ---
SYMBOL_INFO=""
SYMBOL_SUCCESS="󰸞"
SYMBOL_WARN="󱈸"
SYMBOL_ERROR="󱎘"
SYMBOL_SELECTED="󰄲"
SYMBOL_UNSELECTED="󰄱"
SYMBOL_ARROW="❯"

# Formats an absolute path to use tilde notation for the home directory.
# Args:
#   1: path - Absolute path
get_display_path() {
    local path="${1}"
    if [[ "${path}" == "${HOME}"/* ]]; then
        echo "~/${path#$HOME/}"
    else
        echo "${path}"
    fi
}

# Compiles SASS files to CSS using sassc, unless in simulation mode.
# Args:
#   1: src  - Source SASS file
#   2: dest - Target CSS file
compile_sass() {
    local src="${1}"
    local dest="${2}"
    if [[ "${DRY_RUN:-}" != "true" ]]; then
        run_safe sassc $SASSC_OPT "${src}" "${dest}"
    fi
}

# --- Logging Infrastructure ---
LOG_FILE="${HOME}/.cache/catppuccin-install.log"
CMD_LOG="/tmp/catppuccin_cmd.log"
ERROR_REPORTED="false"

# Prints a styled header section to the terminal.
# Args:
#   1: label - Section title string
log_header() {
    local header="${1}"
    local symbol="󰧟"
    local sym_color="${COLOR_SUCCESS}"
    if [[ "${header}" == "Installation Summary" ]]; then
        symbol="●"
        sym_color="${COLOR_INFO}"
    elif [[ "${header}" == "Session Integration" ]]; then
        symbol="●"
        sym_color="${COLOR_SUCCESS}"
    fi
    printf "\r\033[K\n${sym_color}%s${COLOR_RESET} ${COLOR_BOLD}%s${COLOR_RESET}\n" "${symbol}" "${header}"
}

# Writes a timestamped entry to the persistent installer log.
# Args:
#   1: message - Log message text
log_to_file() {
    mkdir -p "$(dirname "${LOG_FILE}")"
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') - ${1}" >> "${LOG_FILE}"
}

# Outputs an info message to console and log file.
# Args:
#   1: message - Message text
log_info() {
    printf "\r\033[K│ %b\n" "$1"
    log_to_file "INFO: $1"
}

# Outputs a success message to console and log file.
# Args:
#   1: message - Message text
log_success() {
    printf "\r\033[K└ ${COLOR_SUCCESS}${SYMBOL_SUCCESS}${COLOR_RESET} %s\n" "$1"
    log_to_file "SUCCESS: $1"
}

# Outputs a warning message to console and log file.
# Args:
#   1: message - Message text
log_warn() {
    printf "\r\033[K│ ${COLOR_WARN}${SYMBOL_WARN}${COLOR_RESET} %s\n" "$1"
    log_to_file "WARN: $1"
}

# Outputs an error message to console and log file.
# Args:
#   1: message - Message text
log_error() {
    printf "\r\033[K│ ${COLOR_ERROR}${SYMBOL_ERROR}${COLOR_RESET} %s\n" "$1"
    log_to_file "ERROR: $1"
    return 0
}

# Outputs a debug message if verbose mode is active.
# Args:
#   1: message - Message text
log_debug() { [[ "${VERBOSE:-}" == "true" ]] && log_info "DEBUG: ${1}" || true; }

# Formats and outputs path assignment info.
# Args:
#   1: label - Component name (e.g., GTK-3)
#   2: path  - Target directory path
log_path() {
    local label="Installing ${1} components to path"
    local path="${2}"
    printf "\r\033[K│ %-38s : '%s'\n" "${label}" "${path}"
    log_to_file "PATH: ${label}: ${path}"
}

# --- Progress Tracking State ---
GLOBAL_TOTAL_STEPS=0   # Total installation steps for current variant
GLOBAL_CURRENT_STEP=0  # Number of steps completed so far

# Increments progress state and refreshes terminal bar.
# Args:
#   1: message - Step description text
update_progress() {
    local msg="$1"
    ((GLOBAL_CURRENT_STEP += 1)) || true
    progress_bar "${GLOBAL_CURRENT_STEP}" "${GLOBAL_TOTAL_STEPS}" "${msg}"
    return 0
}

# Renders progress bar to terminal.
# Args:
#   1: current - Steps completed
#   2: total   - Total steps
#   3: message - Log message text
progress_bar() {
    local current=$1
    local total=$2
    local msg=$3
    local width=30
    local icon="${PROGRESS_ICON:-●}"

    if [[ $total -le 0 ]]; then return 0; fi

    # Calculate percentage
    local percent=$((current * 100 / total))
    [[ $percent -gt 100 ]] && percent=100

    # Calculate bar fills
    local filled=$((current * width / total))
    [[ $filled -gt $width ]] && filled=$width
    local empty=$((width - filled))

    # Print bar to console
    printf "\r\033[K│ ${COLOR_VIOLET}%s${COLOR_RESET} ${COLOR_BOLD}[${COLOR_RESET}" "${icon}"
    printf "${COLOR_CYAN}"
    for ((i=0; i<filled; i++)); do printf "■"; done
    printf "${COLOR_RESET}${COLOR_GRAY}"
    for ((i=0; i<empty; i++)); do printf " "; done
    printf "${COLOR_RESET}${COLOR_BOLD}]${COLOR_RESET}  ${COLOR_CYAN}%3d%%${COLOR_RESET}" "${percent}"

    log_to_file "PROGRESS: ${percent}% - ${msg}"
    return 0
}

# --- Terminal User Interface ---

# Prints the Catppuccin GTK Theme installer banner.
print_banner() {
    clear 2>/dev/null || true
    printf "\n"
    printf "${COLOR_VIOLET}C A T P P U C C I N   G T K   T H E M E${COLOR_RESET}\n"
    printf "${COLOR_GRAY}───────────────────────────────────────${COLOR_RESET}\n\n"

    if [[ "${DRY_RUN:-}" == "true" ]]; then
        printf "  ${COLOR_WARN}${SYMBOL_INFO}${COLOR_RESET}  ${COLOR_BOLD}Simulation Mode Active${COLOR_RESET}\n"
        printf "  ${COLOR_WARN}${SYMBOL_INFO}${COLOR_RESET}  ${COLOR_GRAY}Log file: ${LOG_FILE}${COLOR_RESET}\n\n"
    fi
}

# Navigable keyboard-driven CLI menu.
# Args:
#   1:   prompt  - Question displayed to user
#   2..: options - Selectable menu choices
interactive_menu() {
    local prompt="$1"
    shift
    local options=("$@")
    local selected=0
    local key=""
    local extra_lines=0
    [[ -n "${MENU_NOTE:-}" ]] && extra_lines=1

    printf "\r\033[K"
    tput civis 2>/dev/null || true  # Hide cursor
    printf "  ${COLOR_BOLD}${SYMBOL_ARROW} ${prompt}${COLOR_RESET}\n\n"

    for i in "${!options[@]}"; do printf "\n"; done
    [[ $extra_lines -gt 0 ]] && printf "\n"

    while true; do
        tput cuu $((${#options[@]} + extra_lines)) 2>/dev/null || true
        for i in "${!options[@]}"; do
            if [[ $i -eq $selected ]]; then
                printf "\r\033[K    ${COLOR_INFO}${SYMBOL_SELECTED}${COLOR_RESET} ${COLOR_INFO}${COLOR_BOLD}%s${COLOR_RESET}\n" "${options[$i]}"
            else
                printf "\r\033[K    ${COLOR_GRAY}${SYMBOL_UNSELECTED}${COLOR_RESET} %s\n" "${options[$i]}"
            fi
        done
        if [[ -n "${MENU_NOTE:-}" ]]; then
            printf "\r\033[K    └ ${COLOR_ERROR}   ${COLOR_RESET}:${COLOR_GRAY} %s${COLOR_RESET}\n" "${MENU_NOTE}"
        fi

        # Read arrow and enter key inputs
        read -rsn3 key
        case "$key" in
            $'\e[A') selected=$(( (selected - 1 + ${#options[@]}) % ${#options[@]} )) ;;
            $'\e[B') selected=$(( (selected + 1) % ${#options[@]} )) ;;
            "")      break ;;
        esac
    done

    tput cnorm 2>/dev/null || true  # Restore cursor
    MENU_RESULT=$selected
    echo
}

# Outputs a summary table of the installed configuration.
print_summary() {
    log_header "Installation Summary"

    # Resolve display values
    local theme_val="Mocha"; local theme_label=" (Default)"
    [[ "$macchiato" == "true" ]] && { theme_val="Macchiato"; theme_label=""; }
    [[ "$frappe"    == "true" ]] && { theme_val="Frappe";    theme_label=""; }
    [[ "$blackness" == "true" ]] && { theme_val="Blackness"; theme_label=""; }

    local mode_val="${APPLIED_SCHEME:-Dark Mode}"; local mode_label=""
    [[ -z "${APPLIED_SCHEME:-}" ]] && mode_label=" (Default)"

    local accent_val="Accent"; local accent_label=" (Default)"
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
        accent_val=$(IFS=", "; echo "${resolved_accents[*]}")
        accent_label=""
    fi

    local theme_name="${APPLIED_THEME:-${name:-$THEME_NAME}${ctype}${themes[0]:-}${colors[0]:-}${sizes[0]:-}${tweaks_tag}}"

    local size_val="Standard"; local size_label=" (Default)"
    [[ "$compact" == "true" ]] && { size_val="Compact"; size_label=""; }

    local border_val="None"; local border_label=" (Default)"
    [[ "$border" == "true" ]] && { border_val="2px"; border_label=""; }

    local button_val="Standard"; local button_label=" (Default)"
    [[ "$macos" == "true" ]] && { button_val="macOS"; button_label=""; }

    local radius_val="${roundness}px"; local radius_label=""
    [[ "${roundness}" == "12" ]] && radius_label=" (Default)"

    local files_val="Standard"; local files_label=" (Default)"
    [[ "${files_legacy:-}" == "true" ]] && { files_val="Legacy"; files_label=""; }

    local panel_val="Standard"; local panel_label=" (Default)"
    [[ "$float" == "true" ]] && { panel_val="Floating"; panel_label=""; }

    local shell_op_val="${shell_opacity}"; local shell_op_label=""
    [[ "${shell_opacity}" == "0.85" ]] && shell_op_label=" (Default)"

    local panel_br_val="None"; local panel_br_label=" (Default)"
    [[ "${panel_border}" == "false" ]] && { panel_br_val="None"; panel_br_label=""; }

    # Print table rows
    printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'%s\n" "Color Base"  "${mode_val}"   "${mode_label}"
    printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n"   "GTK-3 Theme" "${theme_name}"
    printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n"   "GTK-4 Theme" "${theme_name}"
    printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n"   "SHELL Theme" "${theme_name}"

    # Conditional rows for optional tweaks
    [[ -z "${theme_label}" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Theme Base"    "${theme_val}"

    [[ -z "${accent_label}" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Accent Color"  "${accent_val}"

    [[ "$compact" == "true" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Window Size"   "${size_val}"

    [[ "$border" == "true" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Window Border" "${border_val}"

    [[ "$macos" == "true" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Window Button" "${button_val}"

    [[ "${roundness}" != "12" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Border Radius" "${radius_val}"

    [[ "${files_legacy:-}" == "true" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Files Style"   "${files_val}"

    [[ "$float" == "true" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Panel Style"   "${panel_val}"

    [[ "${shell_opacity}" != "0.85" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Shell Opacity" "${shell_op_val}"

    [[ "${panel_border}" == "false" ]] && \
        printf "│ ${COLOR_BOLD}%-13s${COLOR_RESET} : '%s'\n" "Panel Border"  "${panel_br_val}"

    printf "│\n"
    printf "└ ${COLOR_SUCCESS}󰅏 ENJOY CATPPUCCIN THEME!${COLOR_RESET}\n"
}

# --- Dependency Management ---

# Checks and auto-installs the 'sassc' dependency.
install_package() {
    log_info "Installing Dependencies"
    PROGRESS_ICON="󰏗"
    if ! has_command sassc; then
        progress_bar 0 100 "Installing sassc..."

        # Determine package manager and install
        local cmd=""
        if   has_command zypper;  then cmd="sudo zypper in -y sassc"
        elif has_command apt-get; then cmd="sudo apt install -y sassc"
        elif has_command dnf;     then cmd="sudo dnf install -y sassc"
        elif has_command yum;     then cmd="sudo yum install -y sassc"
        elif has_command pacman;  then cmd="sudo pacman -Syyu --noconfirm sassc"
        fi

        if [[ -n "$cmd" ]]; then
            # Animate progress bar
            for i in {1..10}; do
                progress_bar $((i * 10)) 100 "Installing sassc..."
                sleep 0.1
            done
            run_safe $cmd
        else
            log_error "Install 'sassc' manually."
            return 1
        fi
    else
        # Animate progress bar for verification
        for i in {1..10}; do
            progress_bar $((i * 10)) 100 "Verifying dependencies..."
            sleep 0.05
        done
    fi
    echo
    log_success "Dependencies Installed"
}

# --- System Version Detection ---

# Probes installed GNOME Shell version to determine directory naming.
detect_gs_version() {
    if has_command gnome-shell; then
        local version_str
        version_str=$(gnome-shell --version)
        SHELL_FULL_VERSION="${version_str##* }"
        SHELL_VERSION="${SHELL_FULL_VERSION%%.*}"
        if [[ "${SHELL_VERSION:-0}" -ge 40 && "${SHELL_VERSION:-0}" -le 48 ]]; then
            GS_VERSION="${SHELL_VERSION}-0"
        elif [[ "${SHELL_VERSION:-0}" -gt 48 ]]; then
            GS_VERSION="48-0"
        else
            GS_VERSION="40-0"
        fi
    else
        GS_VERSION="48-0"
        SHELL_FULL_VERSION="Unknown"
    fi
    export GS_VERSION
    export SHELL_FULL_VERSION
}

# Probes GTK3 and GTK4 library versions.
detect_gtk_versions() {
    if has_command pkg-config; then
        GTK3_VERSION=$(pkg-config --modversion gtk+-3.0 2>/dev/null || echo "3.24.0")
        GTK4_VERSION=$(pkg-config --modversion gtk4 2>/dev/null || echo "4.12.0")
    else
        GTK3_VERSION="3.24.0"; GTK4_VERSION="4.12.0"
    fi
}

# --- SASS Patching Helpers ---

# Patches common GNOME Shell SASS imports with version-specific folder names.
patch_gnome_shell_sass() {
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        return 0
    fi

    local gs_sass_common="${SRC_DIR}/sass/gnome-shell/_common.scss"
    local gs_sass_temp="${SRC_DIR}/sass/gnome-shell/_common-temp.scss"

    if [[ ! -f "${gs_sass_common}" ]]; then
        return 0
    fi

    cp -rf "${gs_sass_common}" "${gs_sass_temp}" || true

    # Set GNOME Shell widget import version
    sed -i "/widgets/s/40-0/${GS_VERSION:-48-0}/" "${gs_sass_temp}" || true

    # Set GNOME Shell extension import version
    local ext_ver="40-0"
    if [[ "${SHELL_VERSION:-0}" -ge 46 ]]; then
        ext_ver="46-0"
    fi
    sed -i "/extensions/s/40-0/${ext_ver}/" "${gs_sass_temp}" || true

    return 0
}

# --- Execution Safety & Diagnostics ---

# Executes commands safely, respecting simulation mode and logging errors.
# Args:
#   $@: Command and arguments to execute
run_safe() {
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        log_debug "${COLOR_GRAY}[SIMULATION SKIP]${COLOR_RESET} $*"
    else
        if ! "$@" > "${CMD_LOG}" 2>&1; then
            log_to_file "COMMAND FAILED: $*"
            show_error_context "$*" "${CMD_LOG}"
            return 1
        fi
    fi
    return 0
}

# Displays error diagnostic details from the command buffer file.
# Args:
#   1: command  - Command that failed
#   2: log_path - Path to command log buffer
show_error_context() {
    local cmd="$1"
    local log="$2"
    local error_output=""

    if [[ -f "$log" ]]; then
        error_output=$(tail -n 10 "$log" | sed 's/^/  > /')
    fi

    printf "\r\033[K\n  ${COLOR_ERROR}${SYMBOL_ERROR}  ${COLOR_BOLD}CRITICAL ERROR DETECTED${COLOR_RESET}\n"
    printf "  ${COLOR_GRAY}──────────────────────────────────────${COLOR_RESET}\n"
    printf "  ${COLOR_BOLD}Command:${COLOR_RESET}  ${COLOR_GRAY}%s${COLOR_RESET}\n" "${cmd}"
    printf "\n  ${COLOR_BOLD}Error Detail:${COLOR_RESET}\n"
    printf "${COLOR_ERROR}%s${COLOR_RESET}\n" "${error_output:-  > No output captured.}"
    printf "  ${COLOR_GRAY}──────────────────────────────────────${COLOR_RESET}\n"
    printf "  ${COLOR_INFO}${SYMBOL_INFO}${COLOR_RESET}  Refer to ${COLOR_BOLD}${LOG_FILE}${COLOR_RESET} for the complete trace.\n\n"

    ERROR_REPORTED="true"
    log_to_file "CRITICAL ERROR CONTEXT:\n$(cat "$log")"
}

# Checks if a command exists in the system PATH.
# Args:
#   1: command - Command name
has_command() {
    command -v "$1" >/dev/null 2>&1
}

# Handles trapped shell errors.
# Args:
#   1: line    - Line number of the error
#   2: command - Command string that triggered the trap
shell_error_handler() {
    local exit_code=$?
    local line="$1"
    local command="$2"

    [[ "${ERROR_REPORTED}" == "true" ]] && return 0
    [[ "${command}" == *"has_command"* ]] && return 0

    printf "\r\033[K\n  ${COLOR_ERROR}${SYMBOL_ERROR}  ${COLOR_BOLD}INTERNAL SCRIPT ERROR${COLOR_RESET}\n"
    printf "  ${COLOR_GRAY}──────────────────────────────────────${COLOR_RESET}\n"
    printf "  ${COLOR_BOLD}Location:${COLOR_RESET}  ${COLOR_GRAY}Line %s${COLOR_RESET}\n" "${line}"
    printf "  ${COLOR_BOLD}Command:${COLOR_RESET}   ${COLOR_GRAY}%s${COLOR_RESET}\n" "${command}"
    printf "  ${COLOR_BOLD}Status:${COLOR_RESET}    ${COLOR_GRAY}Exit code %s${COLOR_RESET}\n" "${exit_code}"
    printf "  ${COLOR_GRAY}──────────────────────────────────────${COLOR_RESET}\n"
    printf "  ${COLOR_INFO}${SYMBOL_INFO}${COLOR_RESET}  Check the instruction logic in the installer libraries.\n\n"

    ERROR_REPORTED="true"
    log_to_file "INTERNAL SCRIPT ERROR at line ${line}: command='${command}', exit_code=${exit_code}"
}

# --- Exit Cleanup ---

# Trapped EXIT cleanup handler. Removes temp files and wipes progress line.
cleanup() {
    local exit_code=$?
    printf "\r\033[K"

    [[ -f "${SRC_DIR}/sass/_tweaks-temp.scss" ]] && rm -f "${SRC_DIR}/sass/_tweaks-temp.scss"
    [[ -f "${SRC_DIR}/sass/gnome-shell/_common-temp.scss" ]] && rm -f "${SRC_DIR}/sass/gnome-shell/_common-temp.scss"

    if [[ -f "${CMD_LOG:-}" ]]; then
        rm -f "${CMD_LOG}"
    fi

    if [[ $exit_code -ne 0 && "${ERROR_REPORTED}" == "false" ]]; then
        printf "\n  ${COLOR_ERROR}${SYMBOL_ERROR}  ${COLOR_BOLD}GENERAL EXECUTION FAILURE${COLOR_RESET}\n"
        printf "  ${COLOR_GRAY}──────────────────────────────────────${COLOR_RESET}\n"
        printf "  ${COLOR_BOLD}Status:${COLOR_RESET}    ${COLOR_GRAY}Exit code %s${COLOR_RESET}\n" "${exit_code}"
        printf "  ${COLOR_INFO}${SYMBOL_INFO}${COLOR_RESET}  Check the console output above for shell error details.\n"
        printf "  ${COLOR_GRAY}──────────────────────────────────────${COLOR_RESET}\n\n"
    fi
}
