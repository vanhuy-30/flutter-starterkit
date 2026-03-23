#!/usr/bin/env bash

set -euo pipefail

if command -v fvm >/dev/null 2>&1; then
  FLUTTER_CMD="fvm flutter"
else
  FLUTTER_CMD="flutter"
fi

usage() {
  echo "Usage: ./scripts/build_app.sh [apk|ipa] [dev|stg|prod]"
  exit 1
}

platform="${1:-}"
flavor="${2:-dev}"

if [[ -z "${platform}" ]]; then
  usage
fi

case "${flavor}" in
  dev)
    target="lib/main_dev.dart"
    ;;
  stg)
    target="lib/main_stg.dart"
    ;;
  prod)
    target="lib/main_prod.dart"
    ;;
  *)
    echo "Invalid flavor: ${flavor}. Use dev, stg, or prod."
    exit 1
    ;;
esac

echo "Installing dependencies..."
${FLUTTER_CMD} pub get

case "${platform}" in
  apk)
    echo "Building APK for flavor '${flavor}' with target '${target}'..."
    ${FLUTTER_CMD} build apk --release --target "${target}"
    ;;
  ipa)
    if [[ "$(uname -s)" != "Darwin" ]]; then
      echo "IPA build is only supported on macOS."
      exit 1
    fi
    echo "Building IPA for flavor '${flavor}' with target '${target}'..."
    ${FLUTTER_CMD} build ipa --release --target "${target}"
    ;;
  *)
    echo "Invalid platform: ${platform}. Use apk or ipa."
    exit 1
    ;;
esac

echo "Build completed."
