---
name: initialize-repo
description: Use this skill when the user wants to scaffold, initialize, or spin up a new repository architecture with Go and Rust workspace structures. Trigger on "initialize repo", "start project", or "new repo".
version: 1.0.0
---

# Initialize Repository Workflow

Use this skill to scaffold a clean Hexagonal/Ports-and-Adapters monorepo environment running Go and Rust.

## Procedural Steps

1. **Extract Repository Name:** Ask the user for the repository name if they haven't explicitly provided one (e.g., "my-awesome-service").
2. **Execute Automation Script:** Run the local shell script at `scripts/init-repo.sh` passing the repository name as the first argument:
   ```bash
   bash ./scripts/init-repo.sh <repository-name>

```

3. **Verify State:** Confirm that the script executed successfully and check that the following directories exist:
* `src/adapter/primary/`
* `src/adapter/secondary/`
* `src/clients/`
* `src/core/`
* `src/libs/`
* `src/wit/`

4. **Scaffold Core Rust Manifest:** Create a base `Cargo.toml` inside `src/`:
```toml
[package]
name = "core"
version = "0.1.0"
edition = "2024"
```

## Rules
* Never alter the directory structure inside `src/` (Adapter, Clients, Core, Libs, Wit are mandatory).
* Do not run `cargo build` until all workspace member directories have their respective `Cargo.toml` files explicitly created.