# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test asdf-plugin-manager https://github.com/asdf-community/asdf-plugin-manager.git "asdf-plugin-manager list"
```

Tests are automatically run in GitHub Actions on push and PR.
