# Project Documentation

This directory contains project-control documentation for the Live Lecture-to-LaTeX Notebook frontend fork.

The upstream `docs/` directory belongs to the Butterfly documentation site. Keep project governance, checkpoint, gate, audit, architecture, and compliance material in `project-docs/` unless there is a deliberate documentation-site migration.

## Current checkpoint stack

```text
CP-2: Split-pane lecture shell
  Status: implemented; Gate 2 pending CI/manual browser validation

CP-3: Notebook session capture
  Status: implemented; Gate 3 pending CI/manual capture validation

CP-4: Local audio + local Whisper transcription
  Status: first implementation present; Gate 4 pending CI/browser/local-companion validation
```

Current detailed status lives in:

```text
project-docs/00-status/current-project-status.md
```

## Directory map

```text
00-status/
  Current PR stack, checkpoint state, and next action plan.

00-audit/
  Repository audit, upstream sync policy, workflow risk findings, and checkpoint-specific audits.

01-product/
  Product brief, MVP scope, non-goals, and user-flow material.

02-architecture/
  Frontend/backend boundary and system architecture notes.

03-frontend/
  Frontend implementation plans and local runtime boundaries.

04-compliance/
  AGPL and third-party license handling.

06-checkpoints/
  Checkpoint definitions and deliverables.

07-gates/
  Hard gate definitions and pass/fail criteria.

08-decisions/
  Architecture Decision Records.

09-runbooks/
  Local development, build, preview, and local companion runbooks.
```

## Operating rule

Work proceeds only after the active gate passes. A checkpoint can contain investigation, documentation, or implementation. A gate is the decision point that allows the next checkpoint to begin.

## Current sequence

```text
CP-0: Fork stabilization and project controls        merged
Gate 0: Repo safe                                    owner settings still require periodic review
CP-1: Build baseline                                 merged
Gate 1: Builds clean                                 passed technically
CP-2: Split-pane shell                               PR #4
Gate 2: UI shell accepted                            pending
CP-3: Notebook capture                               PR #5, stacked on CP-2
Gate 3: Notebook capture accepted                    pending
CP-4: Local audio + local Whisper transcription       PR #6, stacked on CP-3
Gate 4: Audio/transcription accepted                 pending
CP-5: Transcript-first backend contract              planned
Gate 5: Backend contract accepted                    planned
```
