# CP-3: Session Capture and Export Contract

Status: implementation in progress on `project/cp-3-session-capture`.

## Purpose

Produce a stable, local, backend-ready lecture capture bundle without requiring a backend.

## Deliverables

- `LectureSessionManifest`.
- `LecturePageManifest`.
- `LectureCaptureBundle`.
- `LectureCaptureService`.
- Local Capture Session inspection control.
- Serialized Butterfly notebook bytes.
- Page ordering/current-page metadata.
- Page activity timestamps where observed.

## Non-goals

No HTTP upload, backend, audio recording, transcription, AI, LaTeX, authentication, cloud storage, or real generated PDF.

## Gate

CP-3 completes only when Gate 3 Notebook Capture Accepted passes.
