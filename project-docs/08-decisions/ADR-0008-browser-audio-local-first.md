# ADR-0008: Browser audio is local-first

Status: accepted.

## Decision

CP-4 records audio locally in the frontend and exposes it as an AudioCaptureArtifact. Upload, chunking, streaming, transcription, and storage are deferred to the backend-contract checkpoint or later.

## Rationale

This isolates microphone/browser risk from network/backend risk and allows notebook editing behavior to be validated while recording.

## Consequence

CP-4 can be developed and tested without credentials or backend infrastructure.
