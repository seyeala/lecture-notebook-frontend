# Build Baseline Audit

Date: 2026-09-18
Checkpoint: CP-1 Build Baseline
Gate: Gate 1 Builds Clean

## Audit summary

The frontend-only build baseline passed in GitHub Actions on commit `c865c859dd5304875eefba15d244b45e845fda55`.

Evidence:

```text
Frontend Build Baseline: success
Dart quality: success
Inherited Flutter build: success
Runner: ubuntu-26.04
Frontend build job duration: approximately 7 minutes
```

The dedicated frontend job completed checkout, Flutter setup, dependency resolution, Rust/wasm-pack setup, OneNote web library build, nightly asset preparation, Flutter WASM web build, and output verification successfully.

## Toolchain source

The authoritative declaration remains `app/pubspec.yaml`.

```text
Flutter: 3.47.4
Dart SDK constraint: >=3.13.0 <4.0.0
Application package name: butterfly
Application version: 2.6.0-rc.3+198
```

No package/app identity rename is part of CP-1.

## Baseline build path

```bash
rustup toolchain install nightly --component rust-src
cargo install wasm-pack --locked
cd app
flutter pub get
cd ..
dart run tools/build_onenote_web.dart
cd app
cp -rf web_nightly/* web/
GIT_HASH=$(git rev-parse HEAD)
flutter build web --wasm --release --no-web-resources-cdn \
  --dart-define=flavor=nightly \
  --dart-define=version="$GIT_HASH"
```

## Backend requirement check

No backend, database, object storage, authentication provider, AI provider, transcription provider, LaTeX compiler, deployment secret, or API key was required.

## Gate decision

```text
Technical build evidence: PASS
Frontend build reproducibility in CI: PASS
Backend-free requirement: PASS
Deployment-free requirement: PASS
Gate 1 technical decision: PASS
```

Repository governance settings from Gate 0 remain a separate owner-level concern and do not invalidate the successful CP-1 build evidence.
