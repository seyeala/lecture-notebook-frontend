# Project Documentation

This directory contains project-control documentation for the Live Lecture-to-LaTeX Notebook frontend fork.

The upstream `docs/` directory belongs to the Butterfly documentation site. Keep project governance, checkpoint, gate, audit, architecture, and compliance material in `project-docs/` unless there is a deliberate documentation-site migration.

## Current checkpoint

```text
Current checkpoint: CP-0 Fork Stabilization
Current hard gate: Gate 0 Repo Safe
Application code changes: not started
```

## Directory map

```text
00-audit/
  Repository audit, upstream sync policy, and workflow risk findings.

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
