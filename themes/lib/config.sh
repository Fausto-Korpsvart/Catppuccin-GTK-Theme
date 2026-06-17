#!/usr/bin/env bash

# Catppuccin GTK Theme: Configuration
# Defines global constants, options matrices, and default runtime states.
# Author: @fkorpsvart | License: GPL-3.0

# --- System and Path Constants ---
ROOT_UID=0   # Standard POSIX root UID for privilege checks
DEST_DIR=""  # Resolved installation path, set at runtime

# --- Theme Suite Matrix ---
THEME_NAME="Catppuccin"

# Accent colors (empty string signifies base/default variant)
THEME_VARIANTS=('' '-Blue' '-Flamingo' '-Green' '-Grey' '-Lavender' '-Maroon' '-Mauve' '-Peach' '-Pink' '-Red' '-Rosewater' '-Sapphire' '-Sky' '-Teal' '-Yellow')
COLOR_VARIANTS=('-Light' '-Dark')
SIZE_VARIANTS=('' '-Compact')

# --- SASS Compiler Options ---
# -M disables source maps, -t expanded produces readable CSS
SASSC_OPT="-M -t expanded"

# --- Selected Variants Registry ---
themes=()   # Selected accent colors
colors=()   # Selected appearance modes
sizes=()    # Selected size variants
lcolors=()  # Appearance modes for Libadwaita integration

# --- Runtime State & Tweak Flags ---
uninstall="false"       # Uninstall theme variants
libadwaita="false"      # Link theme to GTK4/Libadwaita config
accent="false"          # Enforce non-default accent color
compact="false"         # Enable minimal window padding
frappe="false"          # Catppuccin Frappé background scheme
macchiato="false"       # Catppuccin Macchiato background scheme
blackness="false"       # OLED-friendly black background
float="false"           # Floating GNOME Shell panel style
border="false"          # 2px contrasting window border style
macos="false"           # macOS-style window controls layout
tweaks_tag=""           # Concatenated suffix tags representing active tweaks
ctype=""                # Suffix for active background scheme
window=""               # Suffix for active window button layout
dest=""                 # Destination path override
name=""                 # Theme name override
theme=""                # Standard nomenclature of selected accent
SELECTED_ACCENT=""      # Resolved active accent name

shell_opacity="0.85"    # GNOME Shell panel alpha transparency value
roundness="12"          # Widget border radius in pixels
panel_border="true"     # GNOME Shell panel border toggle
files_legacy="false"    # Legacy Nautilus file manager styling toggle

# --- Destination Pathway Selection ---
# Set path based on user privilege levels (root installs system-wide)
if [[ "$UID" -eq "$ROOT_UID" ]]; then
    DEST_DIR="/usr/share/themes"
else
    DEST_DIR="$HOME/.themes"
fi
