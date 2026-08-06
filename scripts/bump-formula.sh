#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: scripts/bump-formula.sh <version> <checksums.txt>" >&2
}

if [ "$#" -ne 2 ]; then
  usage
  exit 2
fi

VERSION="$1"
CHECKSUMS_FILE="$2"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
FORMULA_FILE="${REPO_ROOT}/Formula/tokenuse.rb"
TMP_FILE=""

cleanup() {
  if [ -n "$TMP_FILE" ] && [ -f "$TMP_FILE" ]; then
    rm -f "$TMP_FILE"
  fi
}
trap cleanup EXIT

if [ ! -f "$CHECKSUMS_FILE" ]; then
  echo "checksums file not found: $CHECKSUMS_FILE" >&2
  exit 1
fi

if [ ! -f "$FORMULA_FILE" ]; then
  echo "formula not found: $FORMULA_FILE" >&2
  exit 1
fi

checksum_for() {
  platform="$1"
  filename="tokenuse_${VERSION}_${platform}.tar.gz"
  checksum="$(awk -v target="$filename" '$2 == target { print $1 }' "$CHECKSUMS_FILE")"

  if [ -z "$checksum" ]; then
    echo "missing checksum for $filename" >&2
    exit 1
  fi

  if ! printf '%s' "$checksum" | grep -Eq '^[0-9a-fA-F]{64}$'; then
    echo "invalid checksum for $filename: $checksum" >&2
    exit 1
  fi

  printf '%s' "$checksum"
}

DARWIN_AMD64="$(checksum_for darwin_amd64)"
DARWIN_ARM64="$(checksum_for darwin_arm64)"
LINUX_AMD64="$(checksum_for linux_amd64)"
LINUX_ARM64="$(checksum_for linux_arm64)"
TMP_FILE="$(mktemp)"

ruby - "$FORMULA_FILE" "$VERSION" "$DARWIN_AMD64" "$DARWIN_ARM64" "$LINUX_AMD64" "$LINUX_ARM64" > "$TMP_FILE" <<'RUBY'
formula_path, version, darwin_amd64, darwin_arm64, linux_amd64, linux_arm64 = ARGV
text = File.read(formula_path)

unless text.sub!(/version "[^"]+"/, %(version "#{version}"))
  abort "version line not found in #{formula_path}"
end

checksums = [darwin_amd64, darwin_arm64, linux_amd64, linux_arm64]
index = 0
text = text.gsub(/sha256 "[0-9a-fA-F]{64}"/) do
  checksum = checksums[index]
  abort "more sha256 lines than expected in #{formula_path}" unless checksum
  index += 1
  %(sha256 "#{checksum}")
end

abort "expected 4 sha256 lines in #{formula_path}, found #{index}" unless index == 4

print text
RUBY

mv "$TMP_FILE" "$FORMULA_FILE"
TMP_FILE=""

echo "Updated Formula/tokenuse.rb to v${VERSION}"
