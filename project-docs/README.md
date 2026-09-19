# Project Documentation

This directory contains project-control documentation for the Live Lecture-to-LaTeX Notebook frontend fork.

The upstream `docs/` directory belongs to the Butterfly documentation site. Keep project governance, checkpoint, gate, audit, architecture, compliance, and runbook material in `project-docs/` unless there is a deliberate documentation-site migration.

## Current checkpoint

```text
Current stacked branch: project/cp-1-build-baseline
Base branch for CP-1 while CP-0 is open: project/bootstrap-controls
Current checkpoint on this branch: CP-1 Build Baseline
Current hard gate on this branch: Gate 1 Builds Clean
Application feature code changes: not started
Backend dependency: none
```

CP-0 remains the first gate for the repository. CP-1 is stacked on CP-0 so the build-baseline work can be reviewed without waiting for CP-0 owner-side settings.

## Directory map

```text
00-audit/
  Repository audit, upstream sync policy, workflow risk findings, and build-baseline audit.

01-product/
  Product brief, MVP scope, non-goals, and user-flow material.

02-architecture/
  Frontend/backend boundary and system architecture notes.

04-compliance/
  AGPL and third-party license handling.

06-checkpoints/
  Checkpoint definitions and deliverables.

07-gates/
  Hard gate definitions and pass/fail criteria.

08-decisions/
  Architecture Decision Records.

09-runbooks/
  Local development, frontend build, and future operational instructions.
```

## Operating rule

Work proceeds only after the active gate passes. A checkpoint can contain investigation, documentation, or implementation. A gate is the decision point that allows the next checkpoint to begin.

## Immediate sequence

```text
CP-0: Fork stabilization and project controls
Gate 0: Repo safe
CP-1: Build baseline
Gate 1: Builds clean
CP-2: Split-pane shell
Gate 2: UI shell accepted
```

## CP-1 rule

CP-1 must remain frontend-only. It may add build documentation and a frontend build workflow. It must not add a backend, API client, secrets, auth, AI calls, audio recorder, PDF viewer, split-pane UI, or deployment pipeline.
