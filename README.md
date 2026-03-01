# homebrew-tap

Homebrew tap for Shaun Wen formulas.

This repository can host multiple programs under `Formula/`. `myprs` is the first formula.

## Install

```bash
brew install shaunwen/tap/<formula>
```

Example:

```bash
brew install shaunwen/tap/myprs
```

## Upgrade

```bash
brew update
brew upgrade shaunwen/tap/<formula>
```

## Maintainers

To add a new program:

1. Add a new formula file under `Formula/` (for example `Formula/mytool.rb`).
2. Test locally:
   ```bash
   brew install --build-from-source ./Formula/mytool.rb
   brew test mytool
   ```
3. Open a pull request and wait for `brew test-bot` to pass.

To release a new version of `myprs`:

1. Tag and push a new `myprs` release (for example `v0.1.1`).
2. Update `Formula/myprs.rb` with the new `url` and `sha256`.
   - Update source tarball `url` + `sha256` (`archive/refs/tags/vX.Y.Z.tar.gz`).
   - Update arm64 binary resource `url` + `sha256` (`releases/download/vX.Y.Z/...aarch64-apple-darwin.tar.gz`).
3. Open a pull request with the formula change.
4. Wait for `brew test-bot` to pass and upload bottle artifacts.
5. Add the `pr-pull` label to the PR to trigger bottle publishing and bottle block updates.
6. After the workflow completes, users can install prebuilt bottles with `brew install shaunwen/tap/myprs` on supported platforms.
