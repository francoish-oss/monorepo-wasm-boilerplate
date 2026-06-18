#!/bin/bash
# .agents/skills/initialize-repo/scripts/init-repo.sh

REPO_NAME=$1

if [ -z "$REPO_NAME" ]; then
  echo "Error: Missing repository name argument."
  exit 1
fi

echo "📁 Creating folder architecture..."
mkdir -p src/adapter/primary
mkdir -p src/adapter/secondary
mkdir -p src/clients
mkdir -p src/core
mkdir -p src/libs
mkdir -p src/wit

echo "🐹 Initializing Go module..."
go mod init "$REPO_NAME"

echo "🦀 Setting up Cargo.toml workspace..."
cat << EOF > Cargo.toml
[workspace]
resolver = "2"
members = [
    "src/core",
    "src/libs",
]
EOF

echo "✅ Script execution finished successfully."