<div align="center">

# asdf-plugin-manager [![Build](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/build.yml/badge.svg)](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/build.yml) [![Lint](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/lint.yml/badge.svg)](https://github.com/aabouzaid/asdf-plugin-manager/actions/workflows/lint.yml)

[plugin-manager](https://github.com/aabouzaid/asdf-plugin-manager) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add plugin-manager
# or
asdf plugin add plugin-manager https://github.com/aabouzaid/asdf-plugin-manager.git
```

plugin-manager:

```shell
# Show all installable versions
asdf list-all plugin-manager

# Install specific version
asdf install plugin-manager latest

# Set a version globally (on your ~/.tool-versions file)
asdf global plugin-manager latest

# Now plugin-manager commands are available
asdf-plugin-manager --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/aabouzaid/asdf-plugin-manager/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ahmed AbouZaid](https://github.com/aabouzaid/)
