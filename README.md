# shaunwen's Homebrew Tap

Homebrew tap for my terminal tools.

## Install

```bash
brew tap shaunwen/tap
```

## Install Packages

```bash
brew install shaunwen/tap/<name>
```

## Packages

### Formulae

- `backsync` - One-way mirror backup of a source folder to a target folder
- `myprs` - Terminal UI for viewing your authored Bitbucket pull requests
- `readr` - Track daily reading across bookokrat, Preview and Apple Books (macOS only)

## Update / Uninstall

```bash
brew update
brew upgrade

brew uninstall <name>
```

## Notes

- Run `brew info shaunwen/tap/<name>` for per-tool caveats (permissions, setup steps, etc.).
- `readr` needs Accessibility and Full Disk Access; after `brew upgrade readr`, run `readr daemon install` again to restart its tracker.

## Manual Cleanup

Homebrew formulae don't remove user data. Delete these to start over:

- `backsync`: `~/.config/backsync/`
- `myprs`: `~/.config/myprs/`
- `readr`: `~/.config/readr/`, `~/.local/share/readr/`, `~/Library/Logs/readr/`, the Keychain item `readr-smtp`, and `readr daemon uninstall` before uninstalling to remove its launchd agent

## Updating Formulae

1. Tag and publish a release in the tool's repository, with prebuilt binaries where the formula expects them.
2. Update the `url` and `sha256` values in `Formula/<name>.rb`, then test locally:
   ```bash
   brew install --build-from-source ./Formula/<name>.rb
   brew test <name>
   brew style shaunwen/tap/<name>
   brew audit --strict --online shaunwen/tap/<name>
   ```
3. Open a pull request and wait for `brew test-bot` to pass on Linux, Intel macOS and Apple Silicon macOS.
4. For formulae that build from source (such as `backsync`), add the `pr-pull` label instead of merging: the `brew pr-pull` workflow uploads the bottles test-bot built to a `<name>-<version>` release in this tap, adds their checksums to the formula and pushes to `main`. Formulae that install prebuilt binaries (such as `readr`) can be merged directly.
