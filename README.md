# Musayyer (مسير)

Offline-first Flutter app for inventory, sales, invoices, debts, and settings (scan/manual mode). Designed for Android-first MVP with Hive local storage and ready for future Firebase sync.

## Features (MVP v1)
- Inventory (products + barcode)
- Sales (POS cart + confirm sale)
- Invoices (today/all)
- Debts (debtors, entries, payments)
- Settings (scan vs manual mode)

## Getting started
1. Install Flutter SDK, Android Studio (SDK/emulator), and VS Code + Flutter extension.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Add camera permission for barcode scanning:
   ```xml
   <uses-permission android:name="android.permission.CAMERA" />
   ```
   Add it inside `android/app/src/main/AndroidManifest.xml`.
4. Run the app:
   ```bash
   flutter run
   ```

## Tech stack
- Hive + Hive Flutter for offline storage
- Provider for state management
- Mobile Scanner for barcode scanning

## Folder structure
```
lib/
  main.dart
  app.dart
  theme.dart
  data/
  models/
  state/
  ui/
```
