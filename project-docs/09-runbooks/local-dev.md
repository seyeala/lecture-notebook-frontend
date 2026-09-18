# Local Development Runbook

Status: CP-1 baseline document.

This runbook is for building the forked Butterfly frontend locally. It does not require a backend, database, storage bucket, AI provider, transcription service, auth provider, or LaTeX compiler.

## Repository

```bash
git clone https://github.com/seyeala/lecture-notebook-frontend.git
cd lecture-notebook-frontend
```

For CP-1 review while CP-0 is still open, check out the stacked branch:

```bash
git checkout project/cp-1-build-baseline
```

After CP-0 and CP-1 are merged, use `develop`.

## Required toolchain

The authoritative Flutter version is declared in `app/pubspec.yaml`:

```text
flutter: 3.47.4
Dart SDK: >=3.13.0 <4.0.0
```

Install Flutter according to the upstream Flutter installation method for your OS, then confirm:

```bash
flutter --version
dart --version
```

The web build also uses the inherited Butterfly OneNote web toolchain:

```bash
rustup toolchain install nightly --component rust-src
cargo install wasm-pack --locked
```

## Dependency install

```bash
cd app
flutter pub get
cd ..
```

## Build OneNote web library

```bash
dart run tools/build_onenote_web.dart
```

## Prepare web flavor assets

The baseline uses the inherited nightly web assets because the upstream deployment workflow used the nightly flavor for non-main builds.

```bash
cd app
cp -rf web_nightly/* web/
cd ..
```

## Build web frontend

```bash
cd app
GIT_HASH=$(git rev-parse HEAD)
flutter build web --wasm --release --no-web-resources-cdn \
  --dart-define=flavor=nightly \
  --dart-define=version="$GIT_HASH"
```

Expected output:

```text
app/build/web/
app/build/web/index.html
```

## No backend required

Do not configure backend URLs, API keys, auth providers, object storage, model credentials, or LaTeX services for CP-1. If a build step asks for those, the build baseline has failed and the dependency should be removed or isolated before proceeding.

## Troubleshooting notes

If `flutter pub get` fails, verify Flutter and Dart versions first. If the OneNote build fails, verify Rust nightly and `wasm-pack`. If `flutter build web --wasm` fails after dependencies install, capture the complete command and error output in `project-docs/00-audit/build-baseline-audit.md` before changing application code.
