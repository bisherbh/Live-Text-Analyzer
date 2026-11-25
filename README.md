# Live Text Analyzer (Flutter)

A high-performance Flutter application built for real-time text analysis with background isolate processing, clean architecture, and modern UI.

---

## 🚀 App Download & Releases
- **Latest Android APK / Release**: [Download Live Text Analyzer v1.0.0](https://github.com/your-username/syncrow_text_analyzer/releases/latest) *(Placeholder URL)*

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
│   ├── abstract/        # Core typedefs (FutureEither)
│   ├── di/              # Dependency Injection (GetIt & Injectable)
│   ├── errors/          # Failure models
│   ├── services/        # Native IsolateService
│   ├── theme/           # Material 3 App Theme
│   └── utils/           # Text analyzer algorithms & helpers
│
├── features/
│   ├── home/            # Home hub screen
│   ├── splash/          # Animated splash screen
│   └── text_analyzer/   # Core Live Text Analyzer feature
│       ├── data/        # Datasources, models & repository implementations
│       ├── domain/      # Entities, repository contracts & usecases
│       └── presentation/# Cubit state management, pages & widgets
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
2. Run `flutter pub get`.
3. Run `flutter pub run build_runner build --delete-conflicting-outputs`.
4. Run `flutter run`.
