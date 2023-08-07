<div align="center">

<!-- omit in toc -->
# asdf-plugin-manager [![Build](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/build.yml/badge.svg)](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/build.yml) [![Lint](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/lint.yml/badge.svg)](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/lint.yml)

Manage [asdf version manager](https://asdf-vm.com) plugins securely and declaratively. **(yes, this is an asdf plugin to manage asdf plugins!)**

Using `asdf-plugin-manager`, you can set plugins Git URL and ref for security and integrity. So it's the only plugin you need to validate manually and the rest are validated via `.plugin-versions` file. Check [usage](#usage) for more details.
</div>

<!-- omit in toc -->
# Contents

- [Why?](#why)
- [Dependencies](#dependencies)
- [Install](#install)
- [Usage](#usage)
- [Known Limitations](#known-limitations)
- [Contributing](#contributing)
- [License](#license)

# Why?

[Asdf is a great universal version manager](https://tech.aabouzaid.com/2022/01/asdf-vm-a-universal-version-manager-tools.html).
However, it lacks a secure and declarative method to manage its plugins. For example, you cannot pin a specific asdf plugin version, which means you will be easily hacked if one of the asdf plugins you use is compromised!

[Many exist requests asking to fix that](https://github.com/asdf-vm/asdf/issues/1577), but no solution has been proposed in `asdf` upstream yet! (Last check: Aug 2023)

Hence, `asdf-plugin-manager` fills the gap to manage asdf plugins securely and declaratively via `.plugin-versions` file.


# Dependencies

- [asdf-vm](https://asdf-vm.com/)
- `bash`, `cat`, `grep`: generic POSIX utilities.
- `ASDF_PLUGIN_MANAGER_PLUGIN_VERSIONS_FILENAME`: Set default name for the file with the list of managed plugins.
  Default: ".plugin-versions".

# Install

Setup plugin:

```shell
asdf plugin add asdf-plugin-manager https://github.com/aabouzaid/asdf-plugin-manager.git
asdf update asdf-plugin-manager 1.0.0
```

Set asdf-plugin-manager version:

```shell
# Show all installable versions
asdf list-all asdf-plugin-manager

# Install specific version
asdf install asdf-plugin-manager latest

# Set a version globally (on your ~/.tool-versions file)
asdf global asdf-plugin-manager latest

# Now asdf-plugin-manager commands are available
asdf-plugin-manager list
```

# Usage

The `.plugin-versions` file syntax:

```
# Name  Git URL                                     Git ref (hash or version)
venom   https://github.com/aabouzaid/asdf-venom.git 2d94d17
```

And `asdf-plugin-manager` args:

```
asdf-plugin-manager help                 : Print this help message
asdf-plugin-manager version              : Print asdf-plugin-manager current version
asdf-plugin-manager list                 : List managed plugins according to .plugin-versions file
asdf-plugin-manager add <plugin-name>    : Add named plugin according to .plugin-versions file
asdf-plugin-manager add-all              : Add all plugins according to .plugin-versions file
asdf-plugin-manager remove <plugin-name> : Remove named plugin according to .plugin-versions file
asdf-plugin-manager remove-all           : Remove all plugins according to .plugin-versions file
```

# Known Limitations

Currently [asdf](https://github.com/asdf-vm/asdf) supports plugin's git-ref on the default branch only (e.g. `main`). So it's not possible to use a git-ref that's not in the default branch (this limitation will be fixed by [asdf-vm/asdf/pull/1204](https://github.com/asdf-vm/asdf/pull/1204)).

# Contributing

Contributions of any kind are welcome! See the [contributing guide](contributing.md).

[Thanks go to these contributors](https://github.com/aabouzaid/asdf-plugin-manager/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ahmed AbouZaid](https://github.com/aabouzaid/)
