<div align="center">

<!-- omit in toc -->
# ASDF Plugin Manager [![Build](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/build.yml/badge.svg)](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/build.yml) [![Lint](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/lint.yml/badge.svg)](https://github.com/asdf-community/asdf-plugin-manager/actions/workflows/lint.yml)

<p align="center">
    <img src="img/asdf-plugin-manager.png" width="100%">
</p>

Manage [asdf](https://asdf-vm.com) plugins securely and declaratively.

Using `asdf-plugin-manager`, you can set asdf plugins Git URL and ref for security and integrity. So it's the only plugin you need to validate manually, and the `.plugin-versions` file will be the source of truth for asdf plugins. Check [example](#example) for more details.

**Yes, this is an asdf plugin to manage asdf plugins!**
</div>

<!-- omit in toc -->
# Contents

- [Why?](#why)
- [Dependencies](#dependencies)
- [Install](#install)
- [Example](#example)
- [Parameters](#parameters)
- [Contributing](#contributing)
- [License](#license)

# Why?

[Asdf is a great universal version manager](https://tech.aabouzaid.com/2022/01/asdf-vm-a-universal-version-manager-tools.html).
However, it lacks a secure and declarative method to manage its plugins. For example, you cannot pin a specific asdf plugin version, which means you will be easily hacked if one of the asdf plugins you use is compromised!

[Many exist requests asking to fix that](https://github.com/asdf-vm/asdf/issues/1577), but no solution has been proposed in `asdf` upstream yet! (Last check: Aug 2023)

Hence, `asdf-plugin-manager` fills the gap to manage asdf plugins securely and declaratively via `.plugin-versions` file.

# Dependencies

- [asdf-vm](https://asdf-vm.com/): Tested with `v0.12.0` but probably will work with older versions.
- `bash`, `cat`, `grep`, `tr`, `cut`, `column`: Generic POSIX utilities.
- `ASDF_PLUGIN_MANAGER_PLUGIN_VERSIONS_FILENAME`: Set default name for the file with the list of managed plugins.
  Default: `.plugin-versions`.

# Install

> **Note**
>
> Remember, `asdf-plugin-manager` is a plugin for asdf and also the actual CLI which actually used to interact with `.plugin-versions` file.

First, setup `asdf-plugin-manager` as asdf plugin in asdf:

```shell
asdf plugin add asdf-plugin-manager https://github.com/asdf-community/asdf-plugin-manager.git
# Pin the asdf-plugin-manager version using git tag or even better using git hash which is immutable.
asdf plugin update asdf-plugin-manager v1.0.0
```

Then, install the actual `asdf-plugin-manager` CLI:

```shell
# Install specific version
asdf install asdf-plugin-manager 1.0.0

# Set a version globally (on your ~/.tool-versions file)
asdf global asdf-plugin-manager 1.0.0

# Now asdf-plugin-manager command is available
asdf-plugin-manager version
```

# Example

Using `asdf-plugin-manager`, the `.plugin-versions` file will be the source of truth for asdf plugins.
Its syntax as follows:

```
# plugin-name  git-url                                               git-ref (hash, tag, or branch)
golang         https://github.com/asdf-community/asdf-golang.git     d8dec15
terraform      https://github.com/asdf-community/asdf-hashicorp.git  c048526
```

You can also export the current added plugins to be managed by `asdf-plugin-manager`:

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

The following all `asdf-plugin-manager` parameters:

```
asdf-plugin-manager help                 : Print this help message
asdf-plugin-manager version              : Print asdf-plugin-manager current version
asdf-plugin-manager export               : List currently installed plugins to be used in .plugin-versions
asdf-plugin-manager list                 : List plugins in .plugin-versions file
asdf-plugin-manager add <plugin-name>    : Add named plugin according to .plugin-versions file
asdf-plugin-manager add-all              : Add all plugins according to .plugin-versions file
asdf-plugin-manager remove <plugin-name> : Remove named plugin according to .plugin-versions file
asdf-plugin-manager remove-all           : Remove all plugins according to .plugin-versions file
```

# Contributing

Contributions of any kind are welcome! See the [contributing guide](contributing.md).

[Thanks go to these contributors](https://github.com/asdf-community/asdf-plugin-manager/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ahmed AbouZaid](https://github.com/aabouzaid/).
