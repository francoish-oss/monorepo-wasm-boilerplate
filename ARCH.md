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

* **What is an Adapter?** The glue. It translates between the messy outside world (HTTP, databases) and your pristine core logic. Primary adapters *drive* the core (inbound); Secondary adapters are *driven by* the core (outbound).
* **What is a Client?** The consumer. It’s the Astro frontend, the CLI tool, or the mobile app that actually calls your Wasm component to get things done.
* **What is a Contract?** The absolute truth. Your WIT files or OpenAPI specs. If it's not defined here, it doesn't exist. It forms the unbreakable boundary of your component.
* **What is the Core?** The brain. Pure business logic. It has zero idea what an HTTP request or IndexedDB is, and it should stay that way. *(See `CORE.MD` for the deep dive).*
* **What is a Host?** The runtime environment. The engine (like Wasmtime or a browser) that actually spins up the Wasm module.
* **What is a Lib?** (Not a political joke, I promise). Dumb utilities. These are dependencies that don't know or care about your business rules—think loggers, date-parsers, or serialization tools.

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

## Skills / LLM Philosophy

LLMs (alone) are incredible tools to manipulate language, but coding ain't about churning out algorithms. Learning `for` loops and `if` statements is easy a 12 yo could do the same. It's not because I know French that I can write a law book without contradicting myself between page 15 and 1500.

Architecture is about organizing, thinking, projecting user needs, handling security, making compromises, and creativity. In these areas, LLMs are sloppier than ever.

However, they *are* incredibly useful for boilerplate code, repetitive tasks where verifying the output is fast, quick POCs, and learning syntax.

To me, a small, local, privacy-friendly LLM + a set of LLM "skills" is a massive help. 
It lets me do what I love faster: confidently building real features for real-world production applications while staying fully aware of the underlying logic.

### Skills implemented

* `define-a-core-business-service`
* `implement-a-core-business-service`
* `define-a-shared-service-interface`
* `implement-a-shared-service-interface`

## Advice on LLM Usage
### Active LLM Usage (Be Careful)
Please don't use LLMs on layers of this architecture where the code isn't repetitive. Think of LLMs as Plop.js on steroids.
Hosts, Clients, and Adapters are often way too specific to let an LLM handle safely. A client could be an Astro page with its own specific set of rules, hooks, and quirks.
### Passive LLM Usage (Spam It)
If a quick LLM prompt acts as a sanity checker or linter for a developer, it's an incredible tool in my opinion :). 
This is especially true in cross-language WebAssembly codebases. 
Use it to ask:
* *"Does this endpoint specify a rate limit?"*
* *"Check if this Core module imports anything from outside the `core/` folder."*
* *"Are my WIT types mapping correctly to my Rust/TS interfaces?"*
