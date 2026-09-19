# CP-1: Build Baseline

Status: complete; technical Gate 1 evidence passed in CI.

## Purpose

Prove that the forked Butterfly frontend can build as a web application before product-specific UI, audio, PDF, backend, or AI work begins.

## Scope

CP-1 is frontend-only.

Included:

```text
fresh clone build instructions
Flutter/Dart toolchain documentation
inherited OneNote web build path documentation
frontend web build workflow
build output verification
known limitations and failure-capture process
```

Excluded:

```text
split-pane UI
audio recording
PDF viewer changes
session capture
backend API client
auth
object storage
AI/transcription/LaTeX integration
deployment/release automation
application renaming
```

## Deliverables

```text
.github/workflows/frontend-build.yml
project-docs/09-runbooks/local-dev.md
project-docs/09-runbooks/frontend-build.md
project-docs/00-audit/build-baseline-audit.md
project-docs/07-gates/gate-1-builds-clean.md
```

## Build command under test

The baseline web build is:

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

## Checkpoint tasks

```text
[x] Document that CP-1 requires no backend.
[x] Document Flutter/Dart toolchain source.
[x] Document local build path.
[x] Add CI workflow for frontend web build.
[x] Verify workflow performs no deployment.
[x] Add Gate 1 criteria.
[x] Run CI workflow successfully.
[x] Record CI build result in build-baseline audit.
[x] Keep inherited build.yml temporarily; revisit reduction after CP-2.
```

## Gate

CP-1 is complete only when Gate 1 passes.

If the workflow cannot run because this branch is stacked on CP-0, Gate 1 technical build criteria have passed.
