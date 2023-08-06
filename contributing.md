# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test plugin-manager https://github.com/aabouzaid/asdf-plugin-manager.git "asdf-plugin-manager --version"
```

Tests are automatically run in GitHub Actions on push and PR.
