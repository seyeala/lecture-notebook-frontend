# Build Baseline Audit

Date: 2026-09-18
Branch: `project/cp-1-build-baseline`
Checkpoint: CP-1 Build Baseline
Gate: Gate 1 Builds Clean

## Audit summary

This audit records the intended frontend-only build baseline for the forked Butterfly app. The baseline has not yet been marked as passed because the build workflow must run successfully before Gate 1 is complete.

## Current toolchain source

The authoritative toolchain declaration is `app/pubspec.yaml`.

```text
Flutter: 3.47.4
Dart SDK constraint: >=3.13.0 <4.0.0
Application package name remains: butterfly
Application version remains: 2.6.0-rc.3+198
```

No package rename or app identity rename is part of CP-1.

## Build path selected

The CP-1 baseline uses the inherited Butterfly web build path rather than a simplified build, because upstream web deployment already used the OneNote web library build and WASM web output.

Selected command sequence:

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

## CI workflow

Added:

```text
.github/workflows/frontend-build.yml
```

Properties:

```text
read-only contents permission
no deployment
no release or tag creation
no secrets required
no backend services required
verifies app/build/web/index.html
```

## Backend requirement check

CP-1 requires no backend. The following remain out of scope:

```text
API gateway
database
object storage
auth provider
AI provider
transcription provider
LaTeX compiler
PDF generation backend
```

## Current result

```text
Status: pending CI/local execution
Gate 1: not passed yet
Reason: workflow added, but successful build output has not yet been recorded
```

## Required evidence to close audit

Record the following after CI or local build runs:

```text
commit SHA
runner or local OS
Flutter version output
Dart version output
Rust version output
whether flutter pub get succeeded
whether build_onenote_web.dart succeeded
whether flutter build web succeeded
warning summary
error summary, if any
final Gate 1 decision
```

## Review note

Because CP-1 is currently stacked on CP-0, GitHub may not run the newly added workflow automatically until CP-0 is merged and CP-1 is retargeted to `develop`, or until the workflow is manually triggered from an eligible branch.
