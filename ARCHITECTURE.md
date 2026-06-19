# Clean WebAssembly-first hexagonal(ish) architecture

## Quick folder structure overview
```text
my-project/
├── adapter/
│   ├── primary/               # Driving adapters (e.g., WIT interface implementation)
│   └── secondary/             # Driven adapters (e.g., IndexedDB or state mock)
├── clients/                   # Web/CLI clients interacting with the Wasm component
├── contracts/                 # Defines the overall interface
│   └── wit/                   # Defines the overall Wasm component interface
│   └── openapi/
├── core/                      # Business logic (domains/services..)
│   └── shared/                # BE CAUTIOUS HERE (interfaces for libs to implement)
│   └── hello-world/           # A single business service
├── hosts/
│   └── wasm-runtime/          # The Wasm host/runner (e.g., Wasmtime)
└── libs/                      # Pure dependencies (logger, specific driver, serialization libs, etc.)

```

## The Concepts: The 10,000-foot view

* **What is an Adapter?** The glue. It translates between the messy outside world (HTTP, databases) and your pristine core logic. Primary adapters *drive* the core (inbound); Secondary adapters are *driven by* the core (outbound). [Read more + Example about Adapter](./src/adapter/ADAPTER.MD)
* **What is a Client?** The consumer. It’s the Astro frontend, the CLI tool, or the mobile app that actually calls your Wasm component to get things done.
* **What is a Contract?** The absolute truth. Your WIT files or OpenAPI specs. If it's not defined here, it doesn't exist. It forms the unbreakable boundary of your component. [Read more + Example about a Contract](./src/contracts/CONTRACT.MD)
* **What is the Core?** The brain. Pure business logic. It has zero idea what an HTTP request or IndexedDB is, and it should stay that way. [Read more + Example about buisness logic](./src/core/CORE.MD)
* **What is a Host?** The runtime environment. The engine (like Wasmtime or a browser or a cloud configuration) that actually spins up the Wasm module.
* **What is a Lib?** (Not a political joke, I promise). Dumb utilities. These are dependencies that don't know or care about your business rules—think loggers, date-parsers, or serialization tools. [Read more + Example about libs](./src/libs/LIBS.MD)

## Folder structure hello world
```text
├── adapter/
│   ├── primary/
│   │   └── http/
│   │       └── identity_handler.rs          # Handles "/register" endpoint
│   └── secondary/
│       └── postgres/
│           └── postgres_repo.rs             # Implements traits from core/identity/ports/
├── clients/
│   └── beautiful-dashboard-app/             # Astro / SvelteKit / React client
├── contracts/
│   └── wit/
│       ├── deps/
│       └── identity.wit                     # world identity-service { export register-user; ... }
├── core/
│   ├── shared/
│   │   └── logger-interface/                # ZERO IMPLEMENTATION HERE Only Interface for Libs to implements
│   └── identity/
│       ├── Cargo.toml
│       └── src/
│           ├── domain/
│           │   ├── entities/
│           │   │   └── user.rs              # The User struct with business rules (e.g., validate age)
│           │   ├── vo/
│           │   │   └── email.rs             # Value Object: guarantees valid email structure format
│           │   ├── errors.rs                # Business errors: EmailAlreadyTaken, WeakPassword
│           │   └── events.rs                # struct UserRegistered { user_id: String }
│           ├── ports/                       # The core demands these exist, but doesn't care how they work.
│           │   ├── user_repo.rs             # pub trait UserRepository { fn save(&self, u: User); }
│           │   └── event_bus.rs             # pub trait EventBus { fn publish(&self, e: UserRegistered); }
│           └── usecases/                    # Orchestrates the transaction step-by-step
│               └── register_user.rs         # Grabs repo -> builds Entity -> saves -> fires event
├── hosts/                                   # The runner setup. Wasm components don't run themselves; they need a host.
│   └── my-cloud-provider/                   # (if cloud or custom docker conf or whatever)
│       └── wadm.yaml                        # Cloud Application Deployment Manifest
└── libs/                                    # Concrete, dumb implementations of non-business utilities.
    └── json-logger/                         # IMPORTS THE SHARED Interface from Core & implements it.
```
