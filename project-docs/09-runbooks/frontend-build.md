# Frontend Build Runbook

Status: CP-1 baseline document.

This runbook defines the frontend-only build path for `lecture-notebook-frontend`. It is intentionally independent of backend services.

## Build invariant

A fresh clone of the frontend repository must build the web target with only local development tools and public package dependencies.

The build must not require:

```text
backend API
database
object storage
auth provider
AI provider
transcription provider
LaTeX compiler
API keys
repository secrets
deployment credentials
```

## CI workflow

The CP-1 workflow is:

```text
.github/workflows/frontend-build.yml
```

It performs these steps:

```text
checkout
set up Flutter from app/pubspec.yaml
show Flutter/Dart/Rust toolchain versions
flutter pub get
install Rust nightly rust-src
install wasm-pack
build inherited OneNote web library
copy nightly web assets
flutter build web --wasm --release --no-web-resources-cdn
verify app/build/web/index.html exists
```

The workflow has read-only repository permissions and performs no deployment.

## Local command sequence

From repository root:

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

## Build output

Expected output:

```text
app/build/web/index.html
```

The build output is an artifact of local/CI verification. CP-1 does not publish, deploy, or upload the web app.

## Stacked-PR note

This branch is stacked on CP-0 while CP-0 is still open. GitHub may not run a newly added workflow until the workflow exists on the target branch. If the CP-1 workflow does not run automatically on the stacked PR, run it after CP-0 is merged and the CP-1 branch is retargeted to `develop`, or trigger it manually with `workflow_dispatch` once the workflow is present on an eligible branch.

## Pass/fail handling

If the build fails, do not start CP-2. Capture:

```text
OS / runner
Flutter version
Dart version
Rust version
failing command
first meaningful compiler error
whether the failure is inherited upstream or caused by CP-1 changes
```

Record the result in `project-docs/00-audit/build-baseline-audit.md`.
