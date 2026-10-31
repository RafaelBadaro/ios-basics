# ios-basics

Template code and small reference projects for anything that I study and code related to Swift/iOS.

## Projects

### Login (SwiftUI) — `Projects/Login/LoginSwiftUI`

A minimal login flow built with SwiftUI, focused on state management, dependency injection and testing (the network call is simulated).

**Flow**

```
LoginView ──tap Login──▶ LoadingView ──▶ HomeView   (success) ──Logout──▶ LoginView
                                    └──▶ ErrorView  (failure) ──Go back─▶ LoginView
```

**Architecture**

- **`ViewState`** enum drives the UI: `loggedOff`, `loading`, `success(ServerResponse)`, `error(LoginError)`. `ContentView` switches on it to show the right screen.
- **`LoginManager`** (`@Observable`) owns the state and calls the service with `async/await`. Any non-`LoginError` is mapped to `.unknown`.
- **`LoginServiceProtocol`** abstracts the API call. `LoginService` fakes it (2s delay, random success/auth failure).
- **`LoginError`** enum: `authFailed`, `networkError`, `timeout`, `unknown`.
- **`ServiceProvider`** picks the service at launch: if the `MOCK_LOGIN_BEHAVIOR` env var is set, it injects `MockUITestLoginService` (`success`, `authError`, `networkError`, `timeout`); otherwise the real service.

**Tests**

- **Unit tests** (Swift Testing, `@Test` / `#expect`) — `LoginManagerTests` covers success and every error case using `LoginServiceMock`.
- **UI tests** (XCTest) — launch the app with `MOCK_LOGIN_BEHAVIOR` to drive deterministic flows: login success, auth error, and going back from the error screen. Views expose `accessibilityIdentifier`s for this.

**Folder structure**

```
LoginSwiftUI/
├── Views/          LoginView, LoadingView, HomeView, ErrorView
├── Managers/       LoginManager
├── Services/       LoginService (+ protocol)
├── Models/         ViewState, LoginError, ServerResponse
├── Shared/         ServiceProvider, MockUITestLoginService
└── PreviewMocks/   mocks for SwiftUI previews
LoginSwiftUITests/    unit tests + mocks
LoginSwiftUIUITests/  UI tests
```

**Requirements:** Xcode 26+, iOS 26.0 deployment target.

**Run:** open `LoginSwiftUI.xcodeproj`, run the `LoginSwiftUI` scheme; `⌘U` runs all tests.
