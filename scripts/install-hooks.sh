#!/usr/bin/env bash
# Bootstrap script for the iOS pre-commit quality gate.
# Each developer runs this once after pulling the changes.
#
#   ./scripts/install-hooks.sh
#
# What it does:
#   1. Verifies Homebrew is installed.
#   2. Runs `brew bundle` to install swiftlint, swiftformat, lefthook, gitleaks.
#   3. Runs `lefthook install` to wire the hooks into .git/hooks/.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v brew >/dev/null 2>&1; then
  echo "Error: Homebrew is not installed."
  echo "Install it from https://brew.sh and re-run this script."
  exit 1
fi

if [ ! -f "Brewfile" ]; then
  echo "Error: Brewfile not found at repo root."
  echo "Expected: $REPO_ROOT/Brewfile"
  exit 1
fi

echo "Installing tooling from Brewfile..."
brew bundle

if ! command -v lefthook >/dev/null 2>&1; then
  echo "Error: lefthook did not install correctly."
  exit 1
fi

echo "Wiring git hooks via lefthook..."
lefthook install

echo ""
echo "Pre-commit hooks are active."
echo "Tools installed: swiftlint, swiftformat, lefthook, gitleaks."
echo "Try a commit on a Swift file to confirm the hook runs."
