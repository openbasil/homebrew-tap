<!--
SPDX-FileCopyrightText: 2026 OpenBasil Contributors

SPDX-License-Identifier: Apache-2.0
-->

# OpenBasil Homebrew Tap

Homebrew tap for [`basil`](https://github.com/openbasil/basil), the OpenBasil
secret / cryptographic-operation broker CLI `basil` and the `basil-nats-bridge`.

## Install

```sh
brew install openbasil/tap/basil
```

or, tapping first:

```sh
brew tap openbasil/tap        # github.com/openbasil/homebrew-tap
brew install basil
```

Upgrade / uninstall as usual:

```sh
brew upgrade basil
brew uninstall basil
```

## Supported platforms

- macOS on Apple Silicon (`aarch64-apple-darwin`)
- Linux on `x86_64` and `arm64` (via Homebrew on Linux / Linuxbrew)

## How this tap is maintained

`Formula/basil.rb` is **generated and pushed automatically** by
[`dist` (cargo-dist)](https://axodotdev.github.io/cargo-dist/) from the
`openbasil/basil` repository on every `basil-v*` release (the
`publish-homebrew-formula` job in that repo's `.github/workflows/release.yml`).

**Do not edit `Formula/*.rb` by hand**! The next release overwrites it. To
change how the formula is produced, edit `dist-workspace.toml` in the main repo.
