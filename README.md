<div align="center">

<!-- omit in toc -->
# asdf-plugin-manager [![Build](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/build.yml/badge.svg)](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/build.yml) [![Lint](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/lint.yml/badge.svg)](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/lint.yml)

Manage [asdf version manager](https://asdf-vm.com) plugins securely and declaratively.

Using `asdf-plugin-manager`, you can set plugins Git URL and ref for security and integrity. So it's the only plugin you need to validate manually and the rest are validated via `.plugin-versions` file. Check [example](#example) for more details.

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

Setup `asdf-plugin-manager` asdf plugin:

```shell
asdf plugin add asdf-plugin-manager https://github.com/aabouzaid/asdf-plugin-manager.git
asdf plugin update asdf-plugin-manager v1.0.0
```

Setup `asdf-plugin-manager` actual CLI:

```shell
# Install specific version
asdf install asdf-plugin-manager latest

# Set a version globally (on your ~/.tool-versions file)
asdf global asdf-plugin-manager latest

# Now asdf-plugin-manager commands are available
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

[Thanks go to these contributors](https://github.com/aabouzaid/asdf-plugin-manager/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ahmed AbouZaid](https://github.com/aabouzaid/).
