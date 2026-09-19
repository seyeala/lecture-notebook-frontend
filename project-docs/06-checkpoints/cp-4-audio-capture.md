# CP-4: Local Audio Capture

Status: contract/UI foundation implemented on `project/cp-4-audio-capture`.

## Purpose

Record lecture audio locally while notebook editing continues, without requiring a backend.

## Deliverables

- AudioCaptureArtifact model.
- AudioCaptureService lifecycle contract.
- Record/Stop control widget.
- Browser media implementation.
- Permission/error states.
- Local duration and artifact summary.
- Tests for lifecycle/state behavior where practical.

## Non-goals

No upload, streaming, transcription, backend storage, AI, WebSocket, or cloud persistence.

## Gate

CP-4 completes only when Gate 4 Audio Capture Accepted passes.
