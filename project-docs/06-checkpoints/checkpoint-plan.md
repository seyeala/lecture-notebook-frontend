# Checkpoint Plan

## How checkpoints work

A checkpoint is a bounded work package. Each checkpoint has deliverables and a corresponding gate. The gate decides whether the next checkpoint may begin.

## CP-0: Fork Stabilization

Purpose: make the fork safe to modify.

Deliverables:

```text
Project docs created.
README revised.
Unsafe upstream workflows disabled.
Branch strategy documented.
AGPL/source-boundary notes documented.
First ADRs written.
```

Gate: Gate 0 Repo Safe.

## CP-1: Build Baseline

Purpose: prove the fork builds before product changes.

Deliverables:

```text
Fresh clone build instructions.
Flutter/Dart toolchain version captured.
Web build command documented.
Build warnings/errors captured.
CI build workflow selected or adapted.
```

Gate: Gate 1 Builds Clean.

## CP-2: Split-Pane Shell

Purpose: prove UI integration feasibility.

Deliverables:

```text
Left pane keeps existing Butterfly notebook behavior.
Right pane displays a static PDF placeholder.
Toolbar contains placeholder Generate control.
No backend integration yet.
```

Gate: Gate 2 UI Shell Accepted.

## CP-3: Session Capture

Purpose: prove the frontend can produce backend-ready artifacts.

Deliverables:

```text
Session ID concept.
Notebook/page export path identified.
Page image or PDF export spike.
Page metadata captured where possible.
```

Gate: Gate 3 Data Export Accepted.

## CP-4: Audio Recording

Purpose: prove browser audio capture.

Deliverables:

```text
Record and stop controls.
Audio blob captured.
Duration displayed.
Local playback test.
Upload-ready audio format selected.
```

Gate: Gate 3 Data Export Accepted, extended for audio.

## CP-5: Backend Contract Stub

Purpose: connect frontend to a fake backend before real AI.

Deliverables:

```text
Create session.
Upload fake assets.
Start fake generation job.
Receive job status.
Display returned sample PDF.
```

Gate: Gate 4 Backend Boundary Accepted.

## CP-6: Generated PDF Viewer

Purpose: make the right pane real enough for MVP.

Deliverables:

```text
Load PDF from backend URL.
Show loading, failed, complete, and stale states.
Download current PDF.
Display version label.
Do not lose previous PDF on failed regeneration.
```

Gate: Gate 4 Backend Boundary Accepted.

## CP-7: Alpha Demo

Purpose: prove the controlled end-to-end instructor workflow.

Deliverables:

```text
Instructor writes notes.
Instructor records audio.
Instructor clicks Generate.
Backend returns generated PDF.
Right pane displays PDF.
Source Code link is visible.
Download PDF/TEX/transcript/logs path exists or is stubbed.
```

Gate: Gate 5 External User Readiness.
