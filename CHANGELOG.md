# Changelog

## [1.4.1](https://github.com/asdf-community/asdf-plugin-manager/compare/v1.4.0...v1.4.1) (2025-05-30)


### Refactors

* update for compatibility with asdf v0.16 ([#71](https://github.com/asdf-community/asdf-plugin-manager/issues/71)) ([c279829](https://github.com/asdf-community/asdf-plugin-manager/commit/c2798294e3a5f84200ae607e3ebeabe41ed761a8))
* use grep -E instead of egrep ([#70](https://github.com/asdf-community/asdf-plugin-manager/issues/70)) ([00ba8ab](https://github.com/asdf-community/asdf-plugin-manager/commit/00ba8ab35e1e8eb5e6506d2967dfc9c002691fee))

## [1.4.0](https://github.com/asdf-community/asdf-plugin-manager/compare/v1.3.1...v1.4.0) (2024-09-23)


### Features

* notify user if the plugin git url doesn't match what in .plugin-versions ([#65](https://github.com/asdf-community/asdf-plugin-manager/issues/65)) ([4be90c2](https://github.com/asdf-community/asdf-plugin-manager/commit/4be90c2633e6697db853420e4a35304f84fbbafb))


### Bug Fixes

* ensure asdf-plugin-manager works in expected worktree ([#56](https://github.com/asdf-community/asdf-plugin-manager/issues/56)) ([309be80](https://github.com/asdf-community/asdf-plugin-manager/commit/309be80421c6cfdd0237ab18a39422a40f98e229))
* use macos compatible sed syntax ([#63](https://github.com/asdf-community/asdf-plugin-manager/issues/63)) ([4de7c98](https://github.com/asdf-community/asdf-plugin-manager/commit/4de7c981f35b15360ae5a0adaf8d65460495e4d7))

## [1.3.1](https://github.com/asdf-community/asdf-plugin-manager/compare/v1.3.0...v1.3.1) (2024-03-19)


### Bug Fixes

* update all plugins even if any plugin is already updated ([#45](https://github.com/asdf-community/asdf-plugin-manager/issues/45)) ([4950f98](https://github.com/asdf-community/asdf-plugin-manager/commit/4950f983010c977bc5db50cdf6b57c7c48924548)), closes [#38](https://github.com/asdf-community/asdf-plugin-manager/issues/38)

## [1.3.0](https://github.com/asdf-community/asdf-plugin-manager/compare/v1.2.0...v1.3.0) (2024-02-11)


### Features

* check if .plugin-versions exists before parsing args ([#43](https://github.com/asdf-community/asdf-plugin-manager/issues/43)) ([a57c48f](https://github.com/asdf-community/asdf-plugin-manager/commit/a57c48f16a52ea3193f52b36b5f4a25bce9b0a74))

## [1.2.0](https://github.com/asdf-community/asdf-plugin-manager/compare/v1.1.1...v1.2.0) (2024-01-22)


### Miscellaneous Chores

* release 1.2.0 ([eaeb78c](https://github.com/asdf-community/asdf-plugin-manager/commit/eaeb78c7395930b942ef7b52418df3e85c597a3f))

## [1.1.1](https://github.com/asdf-community/asdf-plugin-manager/compare/v1.1.0...v1.1.1) (2023-09-04)


### Bug Fixes

* use syntax compatible with bash 3 ([#19](https://github.com/asdf-community/asdf-plugin-manager/issues/19)) ([85fbefd](https://github.com/asdf-community/asdf-plugin-manager/commit/85fbefda14280f0eb226c950d880c58ec1410e6f))

## [1.1.0](https://github.com/asdf-community/asdf-plugin-manager/compare/v1.0.0...v1.1.0) (2023-09-04)

### Refactor

* add flag to remove plugin if it's already installed ([#14](https://github.com/asdf-community/asdf-plugin-manager/issues/14)) ([1369b04](https://github.com/asdf-community/asdf-plugin-manager/commit/1369b04bf24c6e6f53f0db4e99f61b19c5dbd3ee))


### Features

* add update and update-all options ([#15](https://github.com/asdf-community/asdf-plugin-manager/issues/15)) ([426f70e](https://github.com/asdf-community/asdf-plugin-manager/commit/426f70e9a5abfe7c77b3df44db7a84a6af901a63)) ([#18](https://github.com/asdf-community/asdf-plugin-manager/issues/18)) ([1e00ba7](https://github.com/asdf-community/asdf-plugin-manager/commit/1e00ba70ff7b76288d27c9fdcda180a10740326f))


### Bug Fixes

* ensure 2nd arg is provided for the options need it ([#17](https://github.com/asdf-community/asdf-plugin-manager/issues/17)) ([a6664fd](https://github.com/asdf-community/asdf-plugin-manager/commit/a6664fd1dbb2322705b0c184fcb9ae0aa1da9f01))

## 1.0.0 (2023-08-07)


### Features

* asdf-plugin-manager first version ([#1](https://github.com/asdf-community/asdf-plugin-manager/issues/1)) ([a68f1d7](https://github.com/asdf-community/asdf-plugin-manager/commit/a68f1d7c904dc282c4e02e218cd4ae530e0db33d))
