#!/usr/bin/env bash
set -e
# Run this script from the project root with Flutter installed.
# It creates the standard native platform folders without replacing lib/.
TMP="$(mktemp -d)"
cp pubspec.yaml "$TMP/pubspec.yaml"
mkdir -p "$TMP/lib" "$TMP/assets"
cp -R lib/* "$TMP/lib/"
cp -R assets/* "$TMP/assets/" 2>/dev/null || true
flutter create --project-name buildlock --org com.buildlock .
cp -R "$TMP/lib/." lib/
cp -R "$TMP/assets/." assets/ 2>/dev/null || true
cp "$TMP/pubspec.yaml" pubspec.yaml
flutter pub get
rm -rf "$TMP"
echo "BuildLock Flutter project bootstrapped. Run: flutter run"
