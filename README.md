# homebrew-myprs

Homebrew tap for `myprs` (Bitbucket pull request TUI).

## Install

```bash
brew tap shaunwen/myprs
brew install myprs
```

## Upgrade

```bash
brew update
brew upgrade myprs
```

## Maintainers

To release a new version:

1. Tag and push a new `myprs` release (for example `v0.1.1`).
2. Update `Formula/myprs.rb` with the new `url` and `sha256`.
   - Update source tarball `url` + `sha256` (`archive/refs/tags/vX.Y.Z.tar.gz`).
   - Update arm64 binary resource `url` + `sha256` (`releases/download/vX.Y.Z/...aarch64-apple-darwin.tar.gz`).
3. Open a pull request with the formula change.
4. Wait for `brew test-bot` to pass and upload bottle artifacts.
5. Add the `pr-pull` label to the PR to trigger bottle publishing and bottle block updates.
6. After the workflow completes, users can install prebuilt bottles with `brew install myprs` on supported platforms.
