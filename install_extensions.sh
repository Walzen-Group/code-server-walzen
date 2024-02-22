#!/bin/bash

extensions=(
    "ms-vsliveshare vsliveshare 1.0.5905"
    "github copilot 1.164.0"
    "github copilot-chat 0.12.2"
    "miramac vscode-exec-node 0.5.6"
    "leizongmin node-module-intellisense 1.5.0"
    "Vue volar 1.8.27"
    "Vue vscode-typescript-vue-plugin 1.8.27"
)

for extension in "${extensions[@]}"; do
    IFS=' ' read -r publisher name version <<< "$extension"
    extension_dir="$HOME/.local/share/code-server/extensions/${publisher}.${name}-${version}"
    if [ ! -d "$extension_dir" ]; then
        echo "Installing $publisher.$name@$version"
        vsix_url="https://ms-vscode.gallery.vsassets.io/_apis/public/gallery/publisher/${publisher}/extension/${name}/${version}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
        wget -O "$HOME/${name}.vsix" -q "$vsix_url"
        code-server --install-extension "$HOME/${name}.vsix"
        rm "$HOME/${name}.vsix"
    fi
done
