#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status

echo "🚀 Starting post-installation setup..."

# 1. Install wkg (Wasm Package Tools) via Cargo
if ! command -v wkg &> /dev/null; then
    echo "📦 Installing wkg..."
    cargo install wkg
else
    echo "✅ wkg is already installed."
fi

# 2. Install wit-bindgen-go
if ! command -v wit-bindgen-go &> /dev/null; then
    echo "🐹 Installing wit-bindgen-go..."
    go install github.com/bytecodealliance/wit-bindgen-go/cmd/wit-bindgen-go@latest
else
    echo "✅ wit-bindgen-go is already installed."
fi

echo "🎉 Post-install setup complete!"