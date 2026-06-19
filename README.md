# Clean WebAssembly-first hexagonal(ish) architecture

### Quick folder structure overview
```text
my-project/
├── adapter/
│   ├── primary/               # Driving adapters (e.g., WIT interface implementation)
│   └── secondary/             # Driven adapters (e.g., IndexedDB or state mock)
├── clients/                   # Web/CLI clients interacting with the Wasm component
├── contracts/                 # Defines the overall interface
│   └── wit/                   # Defines the overall Wasm component interface
│   └── openapi/
├── core/                      # Buisness logic (domains/services..)
│   └── shared/                # BE CAUTIOUS HERE
│   └── hello-world/           # A single buisness service
├── hosts/
│   └── wasm-runtime/          # The Wasm host/runner (e.g., Wasmtime)
└── libs/                      # Whatever dependencies we need (even if it's our own logger..., specific driver, jaxb, serialization libs etc..)
```

# Hosts
## What an host ?

# Clients
## What a client ?

# Contracts
## What a contract ?

# Core
## What a core
### Hello world folder structure
```text
hello-world/
├── adapter/

```

## What is a service ?
## How create a service (matched skills create-a-core-service)

# Adapter


# Libs
## What is a lib ? (not a political joke i promise)
## How to seek a lib ? (matched skills search-lib)
