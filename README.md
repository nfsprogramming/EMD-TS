# EMD-TS — Remote Patient Screening (Demo)

[![Flutter](https://img.shields.io/badge/Flutter-3.47.7-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.5-0175C2?logo=dart)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-blue)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**EMD-TS** is a cross-platform Flutter demonstration application modeling an end-to-end remote patient screening and clinical triage workflow. Built for edge health workers and telemedicine clinics, it demonstrates hardware telemetry status monitoring, multimodal vital sign capture, automated AI risk evaluation, clinical referral escalation, and offline-first edge data caching with batch synchronization.

> [!IMPORTANT]
> **Clinical & Regulatory Disclaimer:** All medical measurements, vital signs, diagnostic waveforms, and AI screening evaluations in this application are **simulated for demonstration purposes only**. The application performs no real-world medical inference or sensor communication. Every clinical screen includes a persistent compliance banner (`SIMULATED / DEMONSTRATION DATA`) and explicit disclaimers: *"AI does not provide a diagnosis. Human review required."*

---

## Implemented Features

The application implements a five-screen guided clinical workflow hosted in an `IndexedStack` to preserve state across screens:

1. **Operational Dashboard (`DashboardScreen`)**
   - Real-time hardware status indicator (`Device Connected`).
   - Daily triage metrics (`24 Patients Today`, `3 Requires Review`, `7 Follow-ups`).
   - Interactive demo patient card (`Anita Sharma`, Age 54, Female) for instant workflow entry.

2. **Patient Details & Multimodal Vitals (`PatientScreen`)**
   - Demographic profile verification.
   - Comprehensive vitals panel:
     - **ECG**: Signal waveform capture indicator (`✓ Captured`).
     - **SpO₂**: Blood oxygen saturation (`94%`).
     - **Heart Rate**: Pulse measurement (`108 BPM`).
     - **Temperature**: Body temperature (`37.4°C`).
     - **Lung Sounds**: Digital stethoscope acoustic capture (`✓ Captured`).
   - Pinned compliance footer banner.

3. **AI Screening & Risk Stratification (`ScreeningScreen`)**
   - High-visibility triage alert banner (`⚠ REVIEW REQUIRED`).
   - Identified trigger indicators:
     - Elevated heart rate.
     - SpO₂ below configured threshold.
     - ECG requires verification.
   - Safety disclaimer: *"AI does not provide a diagnosis. Human review required."*

4. **Referral Management & Escalation (`ReferralScreen`)**
   - `HIGH` priority escalation classification.
   - Clinical escalation routing to `Remote Medical Officer`.
   - Telemetry queue status (`Waiting for review`).
   - Action history log and handover details.

5. **Offline Mode & Edge Synchronization (`OfflineScreen`)**
   - Edge availability verification:
     - Patient data saved locally.
     - Screening available offline.
     - Historical records accessible.
   - Interactive network reconnection simulation with a 3-stage animated transition:
     - `✓ Connection restored`
     - `Synchronizing...` (with active progress indicator)
     - Batch upload summary: `24 records synchronized`, `3 referrals uploaded`, `7 follow-ups updated`.
   - Controls to re-simulate offline and reconnect states.

---

## Tech Stack & Architecture

- **Framework:** Flutter 3.47.7 (Channel stable)
- **Language:** Dart 3.13.5 (SDK constraint `^3.13.0`)
- **Design System:** Material 3 with customized Emerald/Teal clinical theme (`#00897B`)
- **Target Platforms:** Android, iOS, Web
- **State Preservation:** `IndexedStack` navigation shell maintaining screen state and transition animations

### Project Structure

```text
EMD-TS/
├── android/              # Native Android host configuration (Gradle Kotlin DSL, SDK 36.1.0)
├── ios/                  # Native iOS host configuration (Xcode project, Runner)
├── web/                  # Flutter Web host (index.html, manifest.json, icons)
├── lib/
│   ├── main.dart         # Application entry point (EmDtsApp)
│   ├── theme.dart        # Material 3 theme definition with clinical palette
│   ├── models/
│   │   └── demo_data.dart        # Simulated patient profiles, vitals, triggers & metrics
│   ├── screens/
│   │   ├── home_shell.dart       # Persistent navigation shell (NavigationBar + IndexedStack)
│   │   ├── dashboard_screen.dart # Screen 1: Metrics, status, and patient intake
│   │   ├── patient_screen.dart   # Screen 2: Demographics and multimodal vital signs
│   │   ├── screening_screen.dart # Screen 3: AI screening triggers and clinical disclaimers
│   │   ├── referral_screen.dart  # Screen 4: Priority specialist referral escalation
│   │   └── offline_screen.dart   # Screen 5: Edge offline mode & 3-stage reconnect sync
│   └── widgets/
│       └── clinical_scaffold.dart# Standardized clinical scaffold and compliance banners
├── test/
│   └── widget_test.dart  # Automated widget and workflow integration tests
├── pubspec.yaml          # Project dependencies and asset definitions
└── LICENSE               # MIT License
```

---

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.13.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- For Android: Android Studio / Android SDK (API 34+) and Java 17
- For iOS: macOS with Xcode 15+ and CocoaPods
- For Web: Google Chrome or any modern Chromium-based browser

Verify your environment using:
```bash
flutter doctor
```

---

## Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/nfsprogramming/EMD-TS.git
   cd EMD-TS
   ```

2. **Install project dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify code quality:**
   ```bash
   flutter analyze
   ```

4. **Run the test suite:**
   ```bash
   flutter test
   ```

---

## Running the Application

### Web
Launch on the Chrome web engine:
```bash
flutter run -d chrome
```

### Android
Launch on a connected Android device or running emulator:
```bash
flutter run -d android
```

### Windows Desktop (if enabled)
```bash
flutter run -d windows
```

---

## Building Release Artefacts

### Android APK
To compile a standalone release APK:
```bash
flutter build apk --release
```
The output will be generated at `build/app/outputs/flutter-apk/app-release.apk`.

### Web Distribution
To compile a production web bundle:
```bash
flutter build web --release
```
The deployable static assets will be located in the `build/web/` directory.

---

## Releases & Downloads

Pre-built binaries, release notes, and SHA-256 verification checksums are available on the [GitHub Releases](https://github.com/nfsprogramming/EMD-TS/releases) page.

---

## Limitations

- **Demo Data Only:** All telemetry, patient records, and vitals are static demonstration fixtures defined in `lib/models/demo_data.dart`.
- **Mocked AI:** The screening logic does not call machine learning models or remote inference backends.
- **Hardware Integration:** The "Device Connected" status is simulated; physical Bluetooth Low Energy (BLE) or USB serial peripherals are not currently bound.

---

## Contributing

Contributions, bug reports, and enhancements are welcome:

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/clinical-enhancement`).
3. Ensure formatting and static analysis pass (`flutter analyze`).
4. Run all unit and widget tests (`flutter test`).
5. Commit your changes and open a Pull Request.

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
