<h1 align="center">C A T P P U C C I N &nbsp; G T K &nbsp; T H E M E</h1>

<p align="center">
  A modern, clean and smoothing GTK theme based on Catppuccin’s brilliant colour
  palette, designed to transform your Linux desktop into a sophisticated
  and stylish space where you can maximize your productivity.
</p>

> [!NOTE]
> The inspiration for this theme came from my desire to have my favourite Neovim colour palettes integrated throughout my GNOME desktop.<br>
> To achieve this, I drew inspiration from the stunning GTK theme designs by [VinceLiuice](https://github.com/vinceliuice)
> and the [Gusbemacbe's](https://github.com/gusbemacbe): [Suru Plus Icon Theme](https://github.com/gusbemacbe/suru-plus).
> And, of course, from the amazing colour palettes created by each designer and community.

<p align="center">
  <img alt="OS" src="https://img.shields.io/badge/OS-Linux-FCC624?style=for-the-badge&logo=linux&logoColor=white"/>
  <img alt="GTK" src="https://img.shields.io/badge/GTK-2%20%7C%203%20%7C%204-4A90D9?style=for-the-badge">
  <img alt="Stars" src="https://img.shields.io/github/stars/Fausto-Korpsvart/Catppuccin-GTK-Theme?style=for-the-badge">
  <img alt="Last Commit" src="https://img.shields.io/github/last-commit/Fausto-Korpsvart/Catppuccin-GTK-Theme?style=for-the-badge">
  <img alt="License" src="https://img.shields.io/github/license/Fausto-Korpsvart/Catppuccin-GTK-Theme?style=for-the-badge">
</p>

<p align="center">
  <img src="docs/preview/00_gnome.png" alt="Catppuccin GTK Preview" width="100%">
</p>

<details>
<summary>Show more Desktops Environment</summary>

| Cinnamon | XFCE |
| -------- | ---- |
| ![Cinnamon Desktop](docs/preview/00_cinnamon.png) | ![XFCE Desktop](docs/preview/00_xfce.png) |

</details>

## Variants

#### All Catppuccin + Black backgrounds

| Variant | HEX Color |
|:------- | ---------:|
| Mocha | ![Mocha](https://img.shields.io/badge/-%231E1E2E-1E1E2E) |
| Macchiato | ![Macchiato](https://img.shields.io/badge/-%2324273A-24273A) |
| Frappé | ![Frappé](https://img.shields.io/badge/-%23303446-303446) |
| Latte | ![Latte](https://img.shields.io/badge/-%23EFF1F5-EFF1F5) |
| Black | ![Black](https://img.shields.io/badge/-%23000000-000000) |

#### All Catppuccin accent colors

<details>
<summary>Show accents</summary>

| Name | HEX (light) | HEX (dark) |
| ---- | ----------- | ----------:|
| Blue | ![Blue Light](https://img.shields.io/badge/-%231E66F5-1E66F5) | ![Blue Dark](https://img.shields.io/badge/-%2389B4FA-89B4FA)|
| Flamingo | ![Flamingo Light](https://img.shields.io/badge/-%23DD7878-DD7878)| ![Flamingo Dark](https://img.shields.io/badge/-%23F2CDCD-F2CDCD)|
| Green | ![Green Light](https://img.shields.io/badge/-%2340A02B-40A02B)| ![Green Dark](https://img.shields.io/badge/-%23A6E3A1-A6E3A1)|
| Lavender | ![Lavender Light](https://img.shields.io/badge/-%237287FD-7287FD)| ![Lavender Dark](https://img.shields.io/badge/-%23B4BEFE-B4BEFE)|
| Maroon | ![Maroon Light](https://img.shields.io/badge/-%23E64553-E64553)| ![Maroon Dark](https://img.shields.io/badge/-%23EBA0AC-EBA0AC)|
| Mauve | ![Mauve Light](https://img.shields.io/badge/-%238839EF-8839EF)| ![Mauve Dark](https://img.shields.io/badge/-%23CBA6F7-CBA6F7)|
| Peach | ![Peach Light](https://img.shields.io/badge/-%23FE640B-FE640B)| ![Peach Dark](https://img.shields.io/badge/-%23FAB387-FAB387)|
| Pink | ![Pink Light](https://img.shields.io/badge/-%23EA76CB-EA76CB)| ![Pink Dark](https://img.shields.io/badge/-%23F5C2E7-F5C2E7)|
| Red | ![Red Light](https://img.shields.io/badge/-%23D20F39-D20F39)| ![Red Dark](https://img.shields.io/badge/-%23F38BA8-F38BA8)|
| Rosewater | ![Rosewater Light](https://img.shields.io/badge/-%23DC8A78-DC8A78)| ![Rosewater Dark](https://img.shields.io/badge/-%23F5E0DC-F5E0DC)|
| Sapphire | ![Sapphire Light](https://img.shields.io/badge/-%23209FB5-209FB5)| ![Sapphire Dark](https://img.shields.io/badge/-%2374C7EC-74C7EC)|
| Sky | ![Sky Light](https://img.shields.io/badge/-%2304A5E5-04A5E5)| ![Sky Dark](https://img.shields.io/badge/-%2389DCEB-89DCEB)|
| Teal | ![Teal Light](https://img.shields.io/badge/-%23179299-179299)| ![Teal Dark](https://img.shields.io/badge/-%2394E2D5-94E2D5)|
| Yellow | ![Yellow Light](https://img.shields.io/badge/-%23DF8E1D-DF8E1D)| ![Yellow Dark](https://img.shields.io/badge/-%23F9E2AF-F9E2AF)|

</details>

## Quick Install

```bash
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git

cd Catppuccin-GTK-Theme
```

- Support for GTK2/3 and generic themes for some DE.

```bash
./install.sh
```

- Support for GTK4/Libadwaita with symbolic links

```bash
./install.sh -l
```

- This only simulates the installation process. (It does not generate or install the theme)

```bash
./install.sh --dry-run
```

## Advanced customisation

- Support for GTK4
- Legacy Nautilus design
- macOS window buttons

```bash
./install.sh -l --tweaks files-legacy macos
```

- 14px rounded corners for windows & Gnome Shell
- 75% transparency for Gnome Shell

```bash
./install.sh --tweaks radius 14 --shell opacity 0.75 radius 14
```

## Flatpak

- This command uses the styles from the GTK3 themes in ‘~/.themes’

```bash
sudo flatpak override --filesystem=$HOME/.themes
```

- This command uses the icon themes in ~/.icons

```bash
sudo flatpak override --filesystem=$HOME/.icons
```

- This command uses the styles from the GTK4 themes in ‘~/.config/gtk-4.0’

```bash
flatpak override --user --filesystem=xdg-config/gtk-4.0
```

## Supported Distros

- [x] Fedora Family
- [x] Debian Family
- [x] Arch Family

> [!IMPORTANT]
> Tested on the latest versions of each major distribution and their main derivatives.<br>
> It should work on other derivatives, but no official tests have been carried out.

## Documentation

A detailed guide to a deeper understanding of how it works.

- [Catppuccin Gallery](docs/GALLERY.md) — A gallery showing how the theme looks on different DE
- [Advanced Installation](docs/INSTALLATION.md) — General installation, Libadwaita, Flatpak & manual installation
- [CLI References](docs/TWEAKS.md) — Examples of how to use the CLI.

## Related Themes

| Themes Projects | GitHub Repo | Gnome Look |
| ------ |:------:|:------:|
| Catppuccin GTK | [Source](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme) | [Package](https://www.pling.com/p/1715554/) |
| Everforest GTK | [Source](https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme) | [Package](https://www.pling.com/p/1695467/) |
| Gruvbox GTK | [Source](https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme) | [Package](https://www.pling.com/p/1681313/) |
| Kanagawa GTK | [Source](https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme) | [Package](https://www.pling.com/p/1810560/) |
| Material GTK | [Source](https://github.com/Fausto-Korpsvart/Material-GTK-Themes) | [Package](https://www.pling.com/p/1706139/) |
| Nightfox GTK | [Source](https://github.com/Fausto-Korpsvart/Nightfox-GTK-Theme) | [Package](https://www.pling.com/p/1929101/) |
| Osaka GTK | [Source](https://github.com/Fausto-Korpsvart/Osaka-GTK-Theme) | [Package](https://www.pling.com/p/2284009/) |
| Rose Pine GTK | [Source](https://github.com/Fausto-Korpsvart/Rose-Pine-GTK-Theme) | [Package](https://www.pling.com/p/1810530/) |
| Tokyonight GTK | [Source](https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme) | [Package](https://www.pling.com/p/1681315/) |
| Vague GTK | [Soon](https://github.com/Fausto-Korpsvart/Vague-GTK-Theme) | [Soon](https://www.pling.com/p/) |

## Support the Project

If you enjoy the project and would like to support future development:

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?hosted_button_id=LKVTXNA36FTV4)
