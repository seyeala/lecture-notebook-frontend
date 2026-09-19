# Gate 1: Builds Clean

Status: PASS based on successful Frontend Build Baseline, Dart quality, and inherited Flutter build workflows.

## Purpose

Gate 1 prevents UI/product work from starting until the frontend build baseline is known and reproducible.

## Required before passing

```text
Frontend web build command is documented.
Flutter/Dart versions are documented from app/pubspec.yaml.
No backend service is required.
No secrets are required.
No deployment occurs.
CI workflow exists for the frontend web build.
Build output contains app/build/web/index.html.
Known warnings or failures are captured.
```

## Pass criteria

Gate 1 passes only when all items below are true:

```text
[ ] A fresh clone can run the documented local build command.
[ ] .github/workflows/frontend-build.yml runs successfully or an equivalent build log is attached.
[ ] app/build/web/index.html is produced.
[ ] No backend configuration is needed.
[ ] No API keys, storage credentials, auth secrets, or deployment secrets are needed.
[ ] No application feature code was changed in CP-1.
[ ] Build warnings are documented, even if non-blocking.
```

## Fail criteria

Gate 1 fails if any item below is true:

```text
Build requires backend URLs, credentials, secrets, or non-public infrastructure.
Build relies on a developer machine-only workaround.
Build publishes or deploys output.
Build requires modifying product code without documenting the reason.
The inherited Butterfly build path is not understood well enough to reproduce.
```

## Allowed deferrals

The only acceptable deferral is CI execution delay caused by the stacked PR structure while CP-0 is still open. If that happens, the workflow file can be reviewed in CP-1, but Gate 1 must remain pending until the workflow runs successfully after CP-0 is merged or the workflow is manually triggered from an eligible branch.

## Decision record

When Gate 1 passes, record:

```text
date
commit SHA
runner or local OS
Flutter version
Dart version
Rust version
exact command
warnings
pass/fail decision
```

Use `project-docs/00-audit/build-baseline-audit.md` for this record.
