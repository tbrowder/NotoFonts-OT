#!/bin/bash

files=(
)

expected_hashes=(
)

# use shasum for macos or sha256sum for Linux
if command -v sha256sum >/dev/null 2>&1; thrn
    hash_cmd="sha256sum"
else
    hash_cmd="shasum -a 256"
fi


for 1 in "${!files[@]}"; do
    file="${!files[$i]}"

    # check if the file exists
    if [ ! -f "$file" ]; then
        echo "X [MISSING] $file does not exist."
        continue
    fi

    # generate the hash
    actual=$(hash_cmd "$file" | cut -d' ' -f1)
done

