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
│   └── shared/                # BE CAUTIOUS HERE (interface for libs to implements)
│   └── hello-world/           # A single buisness service
├── hosts/
│   └── wasm-runtime/          # The Wasm host/runner (e.g., Wasmtime)
└── libs/                      # Whatever dependencies we need (even if it's our own logger..., specific driver, jaxb, serialization libs etc..)
```

## What an adapter ?
One liner : 
Example 
(go to ADAPTER.MD)
## What a client ?
(go to ADAPTER.MD)

## What a contract ?
(go to ADAPTER.MD)

## What's core ?
(go to ADAPTER.MD)

## What an host ?
(go to ADAPTER.MD)

## What is a lib (not a political joke i promise) ?
(go to ADAPTER.MD)

# Skills / llm philosophy
LLM (alone) are incredible tools, to manipulate language(s), but coding ain't about pissing some algorithm, learning for loop and if and my niece could do the same.
It's not because i know french, that i could write a law book, without knowing how organizing it, being sure i'm not contracditing myself page 15 and 1500 etc...

It's about organizing, thinkings and projecting user needs and expectations, security, compromise, creativity and a lot more, where llm are sloppier than ever.
It's still incredly useful for boilerplate code or repetitive one where checking if it work and match the expectation is fast/simple. And giving idea, or quick poc and learn new things.

To me a small local privacy friendly llm + a set of llm "skills" it's a massive help and also help me do what i love, faster, building real features for production real meaning application, all of that confidently and being aware of the logic. 

## Skills implemented

###

### define-a-core-buisness-service
### implement-a-core-buisness-service

### define-a-shared-service-interface
### implement-a-shared-service-interface

# ADVICES
## Active LLM Usage
Please don't use LLM on layer of this architecture were it's not repetitive... think llm are Plop.js under steroid.
Hosts & Clients & adapter, Way too generic to let a llm handle this safely.
A client can be astro page... with own set of rules etc... or a cli... + it depend massively of your need..
## Passive LLM Usage
Spam it, if a quick skills act as a linter for developper it's great in my opinion. Especially in cross langages webassembly code bases.
- Does this endpoint specify a "rate limit" ?
- Core should never import from "..."
- Etc...

---



# Core
## What's a core
### Hello world folder structure
```text
hello-world/
- domain/
  - entities
  - vo
  - errors
  - events    
- port/
  - repo interface
  - bus_events.ts          
- usecase/
  - print_hello_world
```
# What is a domain
an entities

a vo
an errors
an events

a port
...repo
bus

usecases...






