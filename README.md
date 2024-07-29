<p align="center">
  <img style="border-radius: 20%; width: 240px;" src="assets/images/img_thumbnail.png">
</p>

# GL CashMan

GL CashMan adalah aplikasi yang diperuntukan bagi warga Grand Laswi untuk mempermudah rekap keuangan kas yang ada di komplek Grand Laswi.

## Technology

- Language: Dart
- Database: Supabase
- Image Upload: Firebase Storage

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

- Flutter version : `3.19.4`
- Dart version : `3.3.2`
- You can read Dependency Version on `pubspec.lock`

## Run this Project

**Setup ENV :**

Create file `.env` in project root directory.

```BASH
SUPABASE_URL=[SUPABASE_URL]
SUPABASE_ANON_KEY=[SUPABASE_ANON_KEY]
```

:warning: Please replace value inside [ ] with real keys.

**For Install or get packages :**

```BASH
flutter pub get
```

**For Run using command line plese run this :**

```BASH
flutter run
```

- If you using Visual Studio Code please open menu `Run` and click `Start Debugging`.

## Build APK

For build APK and share to testing team please run this command.

```BASH
flutter build apk --split-per-abi
# flutter build apk --obfuscate --split-debug-info -h
```
