#!/bin/bash

# Download the basic Noto OTF font families corresponding to:
#
#   Adobe Times     -> Noto Serif
#   Adobe Helvetica -> Noto Sans
#   Adobe Courier   -> Noto Sans Mono
#
# The downloaded faces are:
#
#   Regular
#   Bold
#   Italic
#   Bold Italic
#
# Usage:
#
#   ./get-noto-otf.sh
#   ./get-noto-otf.sh /desired/output/directory

set -euo pipefail

BASE_URL="https://notofonts.github.io/latin-greek-cyrillic/fonts"
OUTPUT_DIR="${1:-noto-otf}"

if ! command -v curl >/dev/null 2>&1
then
    echo "Error: curl is required." >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

download-font()
{
    local family="$1"
    local filename="$2"
    local family_dir="$OUTPUT_DIR/$family"
    local url="$BASE_URL/$family/unhinted/otf/$filename"
    local output="$family_dir/$filename"
    local temporary="$output.part"

    mkdir -p "$family_dir"

    if [[ -s "$output" ]]
    then
        echo "Already present: $output"
        return
    fi

    echo "Downloading: $filename"

    rm -f "$temporary"

    if ! curl \
        --fail \
        --location \
        --retry 3 \
        --retry-delay 2 \
        --show-error \
        --output "$temporary" \
        "$url"
    then
        rm -f "$temporary"
        echo "Error downloading:" >&2
        echo "  $url" >&2
        exit 1
    fi

    if [[ ! -s "$temporary" ]]
    then
        rm -f "$temporary"
        echo "Error: downloaded file is empty: $filename" >&2
        exit 1
    fi

    mv "$temporary" "$output"
}

echo
echo "Downloading Noto Serif OTF fonts..."
download-font "NotoSerif" "NotoSerif-Regular.otf"
download-font "NotoSerif" "NotoSerif-Bold.otf"
download-font "NotoSerif" "NotoSerif-Italic.otf"
download-font "NotoSerif" "NotoSerif-BoldItalic.otf"

echo
echo "Downloading Noto Sans OTF fonts..."
download-font "NotoSans" "NotoSans-Regular.otf"
download-font "NotoSans" "NotoSans-Bold.otf"
download-font "NotoSans" "NotoSans-Italic.otf"
download-font "NotoSans" "NotoSans-BoldItalic.otf"

echo
echo "Downloading Noto Sans Mono OTF fonts..."
download-font "NotoSansMono" "NotoSansMono-Regular.otf"
download-font "NotoSansMono" "NotoSansMono-Bold.otf"

echo
echo "Downloaded fonts:"
find "$OUTPUT_DIR" -type f -name '*.otf' -print | sort


echo
echo "Font directory:"
echo "  $(cd "$OUTPUT_DIR" && pwd)"
