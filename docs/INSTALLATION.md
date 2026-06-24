# Advanced Customization

> [!NOTE]
> This is a brief guide detailing advanced commands for customising the theme installation.

## Basic Installation

This basic installation generates themes for GNOME GTK3, GNOME Shell, Cinnamon, XFCE and Mate.

- Clone the repository

```bash
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git
```

- Go to the theme directory

```bash
cd Catppuccin-GTK-Theme
```

- Run Install

```bash
./install.sh
```

## GTK4 & Libadwaita

During the development of GNOME 41, `libadwaita` was introduced; this library builds on top of GTK4
and provides interface components, styles and design patterns that are consistent with GNOME’s guidelines.

In GNOME 42, themes are now managed by GTK4; this means that themes installed in the
directory: `$HOME/.themes` are now exclusively for GTK3.

To ensure that `GTK4/Libadwaita` applications apply custom themes, the theme’s style sheets
must be placed in a new directory: `$HOME/.config/gtk-4.0`

This theme generates those style sheets, but places them in the `$HOME/.themes` directory;
this means we need to move the files from `$HOME/.themes/gtk-4.0` to `$HOME/.config/gtk-4.0`.

The installation script allows you to ‘move’ them automatically, creating symbolic links so
that the themes are applied immediately; this is achieved with the following commands.

- Clone the repository

```bash
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git
```

- Go to the theme directory

```bash
cd Catppuccin-GTK-Theme
```

- Creating directory

```bash
mkdir -p ~/.config/gtk-4.0
```

- GTK4/Libadwaita symlinks

```bash
./install.sh --libadwaita
```

> [!IMPORTANT]
> Only place the `assets/` directory, `gtk.css`, and `gtk-dark.css` files inside `~/.config/gtk-4.0/`.
> **Do not** copy the entire theme folder there.

---

## Manual Installation

### For GKT2/3 and other desktop environments

Download the themes from [Releases](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme/releases) or [gnome-look](https://www.pling.com/u/fkorpsvart)

- Creating directory if not exist

```bash
mkdir -p ~/.themes
```

- Extracting the files

```bash
tar -xf Catppuccin.tar.xz

# or
unzip Catppuccin.zip
```

- Copy into the themes directory

```bash
cp -r Catppuccin-Dark ~/.themes/
cp -r Catppuccin-Light ~/.themes/
```

- Install system-wide (root)

```bash
sudo cp -r Catppuccin-Dark /usr/share/themes/
sudo cp -r Catppuccin-Light /usr/share/themes/
```

### GTK4/Libadwaita

- Create the required directories:

```bash
mkdir -p ~/.config/gtk-4.0
```

> [!NOTE]
> You need to enter the appropriate name depending on the theme you want to link to.

- Method A: Create symlinks manually (Recommended, auto update when reinstall the theme)

```bash
ln -sf ~/.themes/Catppuccin-Dark/gtk-4.0/assets ~/.config/gtk-4.0/assets
ln -sf ~/.themes/Catppuccin-Dark/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
ln -sf ~/.themes/Catppuccin-Dark/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
```

- Method B: Copy theme files directly (Not recommended, but it is an option.)

```bash
cp -r Catppuccin-Dark/gtk-4.0/assets ~/.config/gtk-4.0/
cp Catppuccin-Dark/gtk-4.0/gtk.css ~/.config/gtk-4.0/
cp Catppuccin-Dark/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/
```

> [!IMPORTANT]
> Only place the `assets/` directory, `gtk.css`, and `gtk-dark.css` files inside `~/.config/gtk-4.0/`.
> **Do not** copy the entire theme folder there.

___

## Applying the Theme

| Desktop Environment | Method |
| ------------------- | ------ |
| GNOME | Use GNOME Tweaks or Tuner |
| GTK4 / Libadwaita | Automatically applied via `./install.sh --libadwaita` or Methods A/B |
| Cinnamon | System Settings → Themes |
| XFCE | Appearance + Window Manager |
| MATE | Appearance Preferences |
| CLI Installer | Interactive automatic integration |

## Uninstallation

- Completely uninstall the theme:

```bash
./install.sh --uninstall
```

- Remove only Libadwaita symlinks:

```bash
./install.sh --libadwaita --uninstall
```

## Flatpak Compatibility

- Override flatpak themes to `~/.themes`:

```bash
sudo flatpak override --filesystem=$HOME/.themes
```

- Override flatpak icons to `~/.icons`

```bash
sudo flatpak override --filesystem=$HOME/.icons
```

- Override flatpak themes to `~/.config/gtk-4.0` locally

```bash
flatpak override --user --filesystem=xdg-config/gtk-4.0
```

- Override flatpak themes to `~/.config/gtk-4.0` globally:

```bash
sudo flatpak override --filesystem=xdg-config/gtk-4.0
```

> [!TIP]
> Use [stylepak](https://github.com/refi64/stylepak) for easier Flatpak theming.

## Customisation & CLI Reference

The installation script supports a wide range of configuration flags to customise your deployment
(e.g., accent colours, window button styles, transparency, and background tweaks like pure black OLED mode).

For a complete list of options, advanced commands, and configuration examples, please check our dedicated guide:

**[CLI Options & Tweaks Reference Guide](TWEAKS.md)**
