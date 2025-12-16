
# iOS Clean Architecture SwiftUI Application Skeleton — Codex Prompt

## Role

You are a **Senior iOS Architect**.  
Generate a **SwiftUI iOS application skeleton** that demonstrates **modern, production-grade architecture** and **best practices used by senior iOS engineers**.

The goal is **architecture correctness, modularity, testability, and clarity**, not business features.

---

## 1. General Rules

- Generate **ONLY Swift source files**
- Do **NOT** generate:
  - `.xcodeproj`
  - `.xcworkspace`
  - `Package.swift`
  - assets, storyboards, or resources
- Output must be:
  1. Folder tree
  2. Then file-by-file Swift code
- Use **SwiftUI**
- Use **async/await**
- Code must be compilable when placed into a SwiftUI app target
- No explanatory text outside code and folder structure

---

## 2. Architectural Style

### Clean Architecture (mandatory)
Rules:
- **Domain depends on nothing**
- **Presentation depends only on Domain abstractions**
- **Data implements Domain protocols**
- **Core is shared infrastructure**
- No circular dependencies
- No UIKit in Domain or Data
- No concrete implementations leaked into Presentation

---

## 3. Layer Responsibilities

### Domain Layer

Contains **pure business abstractions**:

- Entities (models without framework dependencies)
- Use Cases (Interactors)
- Repository protocols
- Domain-level errors

Rules:
- No `SwiftUI`, `URLSession`, `UserDefaults`, `Combine`
- No concrete implementations
- All logic expressed via protocols and pure Swift types

---

### Data Layer

Contains **implementations** of Domain abstractions:

- Repository implementations
- Remote data sources
- DTOs
- Mappers (DTO → Domain)
- Network implementations

Rules:
- Implements Domain protocols
- Uses async/await
- Handles decoding, networking, persistence
- No SwiftUI
- No navigation logic

---

### Presentation Layer

Contains **UI and state management only**:

- SwiftUI Views
- ViewModels
- Routers
- UI state models

Rules:
- ViewModels depend ONLY on:
  - Domain protocols
  - Routing protocols
- ViewModels:
  - Annotated with `@MainActor`
  - Contain no concrete implementations
- Views:
  - Are completely passive
  - Do not know about navigation
  - Send only UI events to ViewModel
- No business logic in Views

---

### Core Layer

Shared infrastructure:

- Dependency Injection container
- Factories / Builders
- Networking primitives
- Logging
- Storage abstractions
- Utilities

Rules:
- No feature-specific code
- No SwiftUI Views
- Safe to use everywhere

---

## 4. Feature Modularity

### Feature Modules (mandatory)

- Each screen / feature is an **independent module**
- One module = one screen
- Modules:
  - Do not import each other
  - Are composed only via Router
- Each module exposes a **single public entry point** (Builder / Factory)

Example:
FeatureModule
├─ View
├─ ViewModel
├─ Router interface
├─ ModuleBuilder
---

## 5. ViewModel Rules (strict)

- Annotated with `@MainActor`
- Owns UI state
- Accepts **ONLY protocols** in initializer
- No concrete implementations
- No navigation APIs
- Emits navigation intent via Router protocol

Responsibilities:
- Handle UI events (`onAppear`, `buttonTapped`)
- Call UseCases
- Update UI state
- Notify Router

---

## 6. Navigation (Router-based)

### Router Architecture (mandatory)

- No `NavigationLink`
- No navigation logic in Views
- No navigation logic in ViewModels

Rules:
- Views → send events to ViewModel
- ViewModel → calls Router protocol
- Router:
  - Owns navigation state
  - Uses `NavigationStack` + `path`
  - Builds destination views via factories/builders

There must be:
- Root router
- Feature-level routing protocols

---

## 7. Networking

### Async/Await Network Layer

Must include:
- `HTTPClient` protocol
- Concrete `URLSession` implementation
- Request abstraction (Endpoint / RequestBuilder)
- Typed errors (network, decoding, HTTP status)
- JSON decoding

Rules:
- No networking code in Presentation
- No direct `URLSession` usage outside network layer

---

## 8. Dependency Injection

### DI System (mandatory)

- Central DI container
- Registration:
  - Protocol → Implementation
- Resolution:
  - Used only in Builders / Factories
- No Service Locator usage inside ViewModels
- No global singletons

### Builders / Factories

- Each feature has a Builder
- Builder:
  - Resolves dependencies
  - Constructs ViewModel
  - Constructs View
  - Returns the module entry point

---

## 9. Testability

Code must be test-ready:

- Protocol-based design everywhere
- Mock implementations included
- No hard-coded dependencies
- No static/global state

---

## 10. Folder Structure (required baseline)

You may extend it, but must not break layering.
/App

/Core
/DI
/Networking
/Logging
/Storage

/Domain
/Entities
/UseCases
/Repositories
/Errors

/Data
/Network
/DTO
/Mappers
/Repositories
/DataSources
/Mocks

/Presentation
/Router
/Modules
/
/Common
---

## 11. Output Format (mandatory)

Rules:
    •    No markdown explanations
    •    No prose
    •    No comments outside code
    •    No TODO placeholders without structure
    •    Realistic, senior-level naming and structure
    
## 12. Goal

The result should be a production-quality architectural skeleton suitable for:
    •    Senior iOS interviews
    •    Large-scale apps
    •    Long-term maintainability
    •    Team development

Generate the full structure and code accordingly.
