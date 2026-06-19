# The Core

The core is where your application actually lives. It is isolated, framework-agnostic, and purely focused on business rules. If you swap your database or change your UI framework, the Core should not require a single line of code changed.

## Hello World Folder Structure

```text
hello-world/
├── domain/
│   ├── entities/
│   ├── vo/                  # Value Objects
│   ├── errors/
│   └── events/
├── port/
│   ├── repo_interfaces/     # e.g., UserRepository
│   └── bus_events.ts
└── usecase/
    └── print_hello_world/

```

## What are these things?

### Domain

The domain is the absolute center of your application. It contains the rules of the game. It dictates what is allowed, what is forbidden, and how data changes state.

* **Entities:** Objects that have a distinct identity that persists over time. A `User` is an entity. Even if a user changes their name, email, and address, they are still the same `User` (usually tracked by an ID).
* **VO (Value Objects):** Objects defined entirely by their attributes. They have no distinct identity and are immutable. An `Address` is a value object. If you change the street name, it's fundamentally a different address. If two addresses have the exact same street, city, and zip code, they are the exact same value.
* **Errors:** Domain-specific screw-ups. These are not HTTP 500 errors or SQL syntax errors. These are business errors like `InsufficientFunds`, `UserTooYoung`, or `InvalidEmailFormat`.
* **Events:** Things that have happened in the past that the rest of the system might care about. (e.g., `UserCreated`, `OrderShipped`).

### Port

Ports are interfaces (contracts). They are how the Core says to the outside world: *"I need to save this data, I don't care if you use Postgres, a text file, or IndexedDB, just implement this interface."*

* **Repo:** Interfaces for storing and retrieving entities.
* **Bus:** Interfaces for dispatching events to the outside world.

### Usecase

The orchestrator. Also known as Application Services. A usecase tells the story of a specific feature. It usually follows a strict, boring pattern:

1. Grab data from the outside world via a Port (Repository).
2. Call a method on a Domain Entity to do the actual business logic.
3. Save the updated Entity back via the Port.
4. Return a result or throw a Domain Error.
