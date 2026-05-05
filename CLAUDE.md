# SwiftUIProjectTemplate

## Stack

- Swift 6, SwiftUI, iOS 17+
- Alamofire (networking), SwiftLint, SwiftGen
- Xcode build configurations: Develop, Production
- String Catalogs for localization (`Localizable.xcstrings`)

## Architecture

Three-layer clean architecture (see `/nerd-swift-architecture` for full conventions):

- **PresentationLayer/**: Screens (View + ViewModel), Coordinators, DesignSystem
- **BusinessLayer/**: Services with protocol interfaces
- **DataLayer/**: Networking (Alamofire), Repositories, DTOs/Entities
- **Common/**: Shared utilities, typealiases, environment config

ViewModels use a generic protocol. Navigation is coordinator-driven.

## Nerd Skills (MANDATORY)

Before writing Swift code, invoke the matching nerd skill via the Skill tool. These contain team conventions that override generic Swift best practices.

| Skill | When |
|---|---|
| `/nerd-swiftui-view` | Views, ViewModels, Coordinators, design system |
| `/nerd-swift-codestyle` | Naming, formatting, file organization |
| `/nerd-swift-testing` | Tests (Swift Testing framework) |
| `/nerd-swift-concurrency` | async/await, Tasks, actors, Combine |
| `/nerd-swift-networking` | API clients, requests, responses |
| `/nerd-swift-architecture` | Layer boundaries, repositories, DI |
| `/nerd-swift-security` | Keychain, tokens, biometric auth |
| `/nerd-swift-docc` | DocC documentation |
| `/nerd-swift-code-review` | Code review checklist |

When multiple skills apply, invoke the most specific one first.

## Commands

```bash
# Lint
swiftlint lint --config swiftlint.yml

# Generate assets
swiftgen config run --config swiftgen.yml
```

Build and test via XcodeBuildMCP tools when available, otherwise `xcodebuild`.

## Conventions

- Use `String(localized:)` and String Catalogs for all user-facing strings. No SwiftGen for localization.
- Assets (colors, images, icons) go in `SupportingFiles/Assets/` and are accessed via SwiftGen-generated code.
- Never hardcode colors or font sizes. Use the design system.
- Never use SF Symbols / system images via `Image(systemName:)`. Add the icon to the asset catalog and reference it through the SwiftGen-generated enum (e.g. `Image(asset: Asset.Icons.someIcon)`).
- Never use system colors (`Color.blue`, `UIColor.systemBackground`, etc.). Define the color in the asset catalog and reference it through the SwiftGen-generated enum (e.g. `Asset.Colors.primary.swiftUIColor`).
- Colors and image assets must always be accessed via the strongly-typed SwiftGen-generated enums, never by string name.
- Follow existing architecture. Do not introduce new patterns without discussion.
- If a change touches more than 3 files, describe the plan first.
- Never include `Co-Authored-By` or any Claude/AI attribution in commit messages.
