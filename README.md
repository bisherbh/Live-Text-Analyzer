# Live Text Analyzer (Flutter)

A high-performance Flutter application built for real-time text analysis with background isolate processing, clean architecture, and modern UI.

- **Flutter Version**: Flutter 3.44.8 (Dart SDK ^3.12.2)

---

## 🚀 App Download & Releases
- **Latest Android APK / Release**: [Download Live Text Analyzer v1.0.0](https://drive.google.com/file/d/1-Aj3zMMoQko8FYB96buhTosyb_pBtY2Q/view?usp=sharing) *(Placeholder URL)*

---

## 🛠️ Key Technical Highlights
1. **Native Dart Isolate API (`Isolate.run`)**: Offloads CPU-heavy text metrics calculation completely off the main UI thread.
2. **Debouncing & Outdated Result Prevention**: 300ms input debouncing coupled with `millisecondsSinceEpoch` request ID tracking ensures users never see outdated statistics.
3. **Functional Error Handling**: Built with `dartz` `Either<Failure, ...>` across repository and usecase layers.
4. **Resilient Isolate Failures**: Background isolate crash simulation with automatic error handling and recovery.
5. **Advanced Text Processing**:
   - Strict A-Z English word matching.
   - Character counts including commas (`,`) and dots (`.`).
   - Optional English stop-word filtering.

---

## 🏛️ Project Architecture (Feature-Based Clean Architecture)

```text
lib/
├── core/
│   ├── abstract/        # Shared type definitions
│   ├── di/              # Dependency injection setup
│   ├── errors/          # Error and failure types
│   ├── services/        # Shared services, including isolate support
│   ├── theme/           # App colors and theme
│   └── utils/           # Text analysis helpers
│
├── features/
│   ├── home/            # Home screen
│   ├── splash/          # Splash screen
│   └── text_analyzer/   # Text analyzer feature
│       ├── data/        # Data sources, models, and repositories
│       ├── domain/      # Entities, repository contracts, and use cases
│       └── presentation/# Cubit, screens, and widgets
│
└── main.dart
```

---

## 🧪 Running Tests
Execute unit and widget tests using:
```bash
flutter test
```

## 💻 Getting Started
1. Clone the repository.
2. Ensure you are using **Flutter 3.44.8**.
3. Run `flutter pub get`.
4. Run `flutter pub run build_runner build --delete-conflicting-outputs`.
5. Run `flutter run`.
