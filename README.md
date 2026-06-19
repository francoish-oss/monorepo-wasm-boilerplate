# {NAME OF PROJECT}

Onboarding
=> Please read architecture to have a quick view, it's short i promise



## Skills / LLM Philosophy

LLMs (alone) are incredible tools to manipulate language, but coding ain't about churning out algorithms. Learning `for` loops and `if` statements is easy a 12 yo could do the same. It's not because I know French that I can write a law book without contradicting myself between page 15 and 1500.

Architecture is about organizing, thinking, projecting user needs, handling security, making compromises, and creativity. In these areas, LLMs are sloppier than ever.

However, they *are* incredibly useful for boilerplate code, repetitive tasks where verifying the output is fast, quick POCs, and learning syntax.

To me, a small, local, privacy-friendly LLM + a set of LLM "skills" is a massive help.
It lets me do what I love faster: confidently building real features for real-world production applications while staying fully aware of the underlying logic.

### Skills implemented

* `initialize-folder-of-an-http-adapter`
* `initialize-folder-of-an-spin-adapter`
* `initialize-folder-of-an-sql-adapter`


* `define-a-core-business-service`
* `implement-a-core-business-service`

* `define-a-shared-service-interface`
* `implement-a-shared-service-interface`


## Advice on LLM Usage
### Active LLM Usage (Be Careful)
Please don't use LLMs on layers of this architecture where the code isn't repetitive. Think of LLMs as Plop.js on steroids.
Hosts, Clients, and Adapters are often way too specific to let an LLM handle safely. A client could be an Astro page with its own specific set of rules, hooks, and quirks. (Maybe http adapter and sql if clear)
### Passive LLM Usage (Spam It)
If a quick LLM prompt acts as a sanity checker or linter for a developer, it's an incredible tool in my opinion :).
This is especially true in cross-language WebAssembly codebases.
Use it to ask:
* *"Does this endpoint specify a rate limit?"*
* *"Check if this Core module imports anything from outside the `core/` folder."*
* *"Are my WIT types mapping correctly to my Rust/TS interfaces?"*
