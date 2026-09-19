# CP-2: Split-Pane Shell

Status: implementation in progress on `project/cp-2-split-pane-shell`.

## Purpose

Prove that the Butterfly notebook can live inside the lecture product's split-pane workspace without changing document runtime semantics.

## Deliverables

- Responsive `LectureShell`.
- Existing Butterfly editor in the left region.
- Static Generated Notes placeholder in the right region at expanded widths.
- Disabled Generate Notes placeholder control.
- Frontend documentation and Gate 2 criteria.

## Non-goals

No backend, audio recording, real PDF rendering, AI, authentication, storage, session upload, LaTeX, transcription, or deployment work.

## Implementation rule

Prefer composition over modification. Do not refactor `DocumentBloc`, `EditorController`, import/export services, persistence, or canvas input handling in CP-2.

## Gate

CP-2 completes only when Gate 2 passes.
