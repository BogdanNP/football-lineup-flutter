# Contributing to flutter_soccer_lineup

Thank you for your interest in contributing! 🎉

## Getting Started

1. **Fork** this repository.
2. **Clone** your fork: `git clone https://github.com/<your-username>/football-lineup-flutter.git`
3. Create a **feature branch**: `git checkout -b feat/my-feature`
4. **Install dependencies**: `flutter pub get` (inside the package root and inside `example/`)

## Development Guidelines

### Code Style

- Follow the [Dart style guide](https://dart.dev/guides/language/effective-dart/style).
- All public APIs must have `///` dartdoc comments.
- Run `flutter analyze` before submitting; zero warnings are expected.
- Use `flutter format .` to format your code.

### No Hardcoded Values

- **No hardcoded colours** — always use `SoccerLineupThemeData` properties.
- **No hardcoded strings** — all user-visible text must be passed in by the
  consumer.
- **No hardcoded assumptions** about formations, player appearance, or layout.

### Builders Over Hardcoded Widgets

Any visual component that a consumer may reasonably want to replace must expose
a `*Builder` callback parameter.

### Tests

- All new utility functions must have unit tests in `test/`.
- All new widgets must have widget tests in `test/widget_test.dart`.
- Run `flutter test` and ensure all tests pass before opening a PR.

### Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add XYZ feature
fix: correct coordinate mirroring
docs: update README with new example
test: add controller swap tests
refactor: simplify FieldPainter
```

## Pull Request Process

1. Update `CHANGELOG.md` under an `## Unreleased` section.
2. Ensure `flutter analyze` passes with zero warnings.
3. Ensure `flutter test` passes.
4. Open a PR with a clear description of the change.

## Reporting Bugs

Please open a GitHub issue with:
- Flutter/Dart version.
- A minimal reproducible example.
- Expected vs actual behaviour.

## Feature Requests

Open a GitHub discussion or issue with:
- A clear use case description.
- Why it cannot be achieved with existing builder/callback APIs.

---

Thank you for helping make `flutter_soccer_lineup` better! ⚽
