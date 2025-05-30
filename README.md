<div align="center">

<p align="center">
  <a href="https://devopshive.net/" style="display: block; padding: 1em 0;">
    <img width="128px" alt="ASDF Plugin Manager Logo" border="0" src="img/asdf-plugin-manager-logo.svg"/>
  </a>
</p>

<h1 >ASDF Plugin Manager</h1>
<p><b>

Let the Kraken manage your [asdf](https://asdf-vm.com) plugins securely and declaratively!

</b></p>

[![Build](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/build.yml/badge.svg)](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/build.yml) [![Lint](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/lint.yml/badge.svg)](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/lint.yml)

</div>

# Overview

ASDF Plugin Manager allows you to pin `asdf` plugin info like Git URL and ref for security and integrity. So, it's the only plugin you need to validate manually, and the `.plugin-versions` file will be the source of truth for all other asdf plugins. Check the [example](#example) for more details.

<!-- omit in toc -->
# Contents

- [Overview](#overview)
- [Why?](#why)
- [Dependencies](#dependencies)
- [Compatibility](#compatibility)
- [Install](#install)
- [Example](#example)
- [Parameters](#parameters)
- [Contributing](#contributing)
- [License](#license)

# Why?

[Asdf is a great universal version manager](https://tech.aabouzaid.com/2022/01/asdf-vm-a-universal-version-manager-tools.html).
However, it lacks a secure and declarative method to manage its plugins. For example, you cannot pin a specific asdf plugin version, which means you will be easily hacked if one of the asdf plugins you use is compromised!

[Many exist requests asking to fix that](https://github.com/asdf-vm/asdf/issues/1577), but no solution has been proposed in `asdf` upstream yet! (Last check: Jan 2024)

Hence, `asdf-plugin-manager` fills the gap to manage asdf plugins securely and declaratively via `.plugin-versions` file.

# Dependencies

- [asdf-vm](https://asdf-vm.com/): Tested with `v0.12.0` but probably will work with older versions.
- `bash`, `cat`, `grep`, `tr`, `cut`, `column`, `sed`, `git`: Generic utilities.
- `ASDF_PLUGIN_MANAGER_PLUGIN_VERSIONS_FILENAME`: Set the default name for the file with the list of managed plugins.
  Default: `.plugin-versions`.

# Compatibility

Since the release of ASDF `v0.16.0` there have been a number of [breaking changes](https://asdf-vm.com/guide/upgrading-to-v0-16.html) as it was [completely rewritten](https://github.com/asdf-vm/asdf/releases/tag/v0.16.0). Use the table below to determine which version of `asdf-plugin-manager` to use.

| ASDF Version           | Compatible Plugin Manager Version |
|------------------------|-----------------------------------|
| v0.15.0 (or older)     | v1.4.0 (or older)                 |
| v0.16.0 (or newer)     | v1.5.0 (or newer)                 |

# Install

> **Note**
>
> Remember, `asdf-plugin-manager` is a plugin for asdf and also the actual CLI which actually used to interact with `.plugin-versions` file.

First, setup `asdf-plugin-manager` as asdf plugin in asdf:

<!-- x-release-please-start-version -->
```shell
asdf plugin add asdf-plugin-manager https://github.com/asdf-community/asdf-plugin-manager.git
# Pin the asdf-plugin-manager version using git tag or even better using git hash which is immutable.
asdf plugin update asdf-plugin-manager v1.3.1
```
<!-- x-release-please-end -->

Then, install the actual `asdf-plugin-manager` CLI:

<!-- x-release-please-start-version -->
```shell
# Install specific version
asdf install asdf-plugin-manager 1.3.1

# Set the plugin version (on your ~/.tool-versions file)
asdf set asdf-plugin-manager 1.3.1

# Now asdf-plugin-manager command is available
asdf-plugin-manager version
```
<!-- x-release-please-end -->

# Example

Using `asdf-plugin-manager`, the `.plugin-versions` file will be the source of truth for asdf plugins.
Its syntax is as follows:

```
# plugin-name  git-url                                               git-ref (hash, tag, or branch)
golang         https://github.com/asdf-community/asdf-golang.git     d8dec15
terraform      https://github.com/asdf-community/asdf-hashicorp.git  c048526
```

You can also export the currently added plugins to be managed by `asdf-plugin-manager`:

```shell
asdf-plugin-manager export > .plugin-versions
```

From now on, you can use `.plugin-versions` to manage asdf plugins.

```shell
# Add all plugins according to .plugin-versions file
asdf-plugin-manager add-all
```

Or

```shell
# Add named plugin according to .plugin-versions file
asdf-plugin-manager add golang
```

# Parameters

The following are all `asdf-plugin-manager` parameters:

```
asdf-plugin-manager help                 : Print this help message
asdf-plugin-manager version              : Print asdf-plugin-manager current version
asdf-plugin-manager export               : List currently installed plugins to be used in .plugin-versions
asdf-plugin-manager list                 : List plugins in .plugin-versions file
asdf-plugin-manager add <plugin-name>    : Add named plugin according to .plugin-versions file
asdf-plugin-manager add-all              : Add all plugins according to .plugin-versions file
asdf-plugin-manager update <plugin-name> : Update named plugin to latest in the system and in the .plugin-versions file
asdf-plugin-manager update-all           : Update all plugins to latest in the system and in the .plugin-versions file
asdf-plugin-manager remove <plugin-name> : Remove named plugin according to .plugin-versions file
asdf-plugin-manager remove-all           : Remove all plugins according to .plugin-versions file
```

# Contributing

Contributions of any kind are welcome! See the [contributing guide](contributing.md).

[Thanks go to these contributors](https://github.com/asdf-community/asdf-plugin-manager/graphs/contributors)!

# License

This project is by [DevOps Hive](https://devopshive.net/) and licensed under an open-source license. For more details, check  [LICENSE](LICENSE).
