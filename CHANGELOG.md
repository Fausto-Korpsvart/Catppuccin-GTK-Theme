# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/) and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.0.1] - 2026-06-22

### Changed

- Refactored CI/CD pipeline to support hybrid manual-automated changelogs.
- Moved technical commit logs to a collapsed details section in GitHub Releases.

## [1.0.0] - 2026-06-15

- Initial development framework and core architecture design for the theme ecosystem.

### 🚨 BREAKING CHANGES

- Deprecated the legacy, unversioned deployment model. The repository has transitioned to a structured, modular automation framework managed via GitHub Actions.
- Structural changes require existing manual installations to clean their target directories before upgrading.

### Added

- Automated SASS compilation pipeline powered by `sassc`.
- Standalone, architecture-agnostic changelog generator engine inside `.github/scripts/`.
- Automated asset deployment configuration for semantic releases using dynamic wildcard matching (`*.tar.xz`).
- Implemented an interactive terminal installer with comprehensive diagnostic output for cross-desktop theme deployment.

### Changed

- Overhauled repository architecture to segregate CI/CD automation logic from the active theme source tree.
- Restructured `GTK3`, `GTK4`, and `Cinnamon` codebase layout to streamline long-term component maintenance.
- Migrated compilation workflows to a centralized combinatorial engine (`packager.sh`).

### Fixed

- Fixed a case-sensitivity string parsing vulnerability for conventional commit prefixes inside the automation hooks.

[1.0.1]: https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme/compare/v0.1.0...v1.0.0
