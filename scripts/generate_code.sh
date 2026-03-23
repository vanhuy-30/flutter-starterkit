#!/usr/bin/env bash

set -euo pipefail

if command -v fvm >/dev/null 2>&1; then
  FLUTTER_CMD="fvm flutter"
  DART_CMD="fvm dart"
else
  FLUTTER_CMD="flutter"
  DART_CMD="dart"
fi

mode="${1:-build}"

echo "Installing dependencies..."
${FLUTTER_CMD} pub get

if [[ "${mode}" == "watch" ]]; then
  echo "Watching code generation changes..."
  ${DART_CMD} run build_runner watch --delete-conflicting-outputs
else
  echo "Generating code once..."
  ${DART_CMD} run build_runner build --delete-conflicting-outputs
fi
