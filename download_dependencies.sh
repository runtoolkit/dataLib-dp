#!/usr/bin/env bash

set -euo pipefail

JSON_FILE="dependencies.json"
OUTPUT_DIR="dependencies"

command -v jq >/dev/null || {
    echo "jq is required."
    exit 1
}

command -v curl >/dev/null || {
    echo "curl is required."
    exit 1
}

command -v unzip >/dev/null || {
    echo "unzip is required."
    exit 1
}

mkdir -p "$OUTPUT_DIR"

download_dependency() {
    local dep="$1"

    local id url archive_url tmp zip

    id=$(jq -r '.id' <<<"$dep")
    url=$(jq -r '.url' <<<"$dep")

    [[ -z "$url" || "$url" == "null" ]] && return

    # https://github.com/user/repo(.git) -> https://github.com/user/repo/archive/refs/heads/main.zip
    archive_url="${url%.git}/archive/refs/heads/main.zip"

    tmp="$(mktemp -d)"
    zip="$tmp/$id.zip"

    echo "Downloading $id..."

    curl -sL "$archive_url" -o "$zip"

    unzip -q "$zip" -d "$tmp"

    rm -rf "$OUTPUT_DIR/$id"

    extracted="$(find "$tmp" -mindepth 1 -maxdepth 1 -type d | head -n1)"

    mv "$extracted" "$OUTPUT_DIR/$id"

    rm -rf "$tmp"
}

for section in required optional; do
    jq -c ".dependencies.${section}[]" "$JSON_FILE" |
    while read -r dep; do
        download_dependency "$dep"
    done
done

echo "Done."