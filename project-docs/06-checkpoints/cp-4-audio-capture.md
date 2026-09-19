# CP-4: Local Audio Capture

Status: contract/UI foundation implemented on `project/cp-4-audio-capture`.

## Purpose

Record lecture audio locally while notebook editing continues, transcribe it locally with Whisper, retain the transcript/timing metadata, and discard temporary lecture audio without requiring a cloud backend.

## Deliverables

- AudioCaptureArtifact model.
- AudioCaptureService lifecycle contract.
- Record/Stop control widget.
- Browser media implementation.
- Permission/error states.
- Local duration and artifact summary.
- Tests for lifecycle/state behavior where practical.
- Runtime-neutral LocalTranscriptionService contract.
- LocalTranscript/TranscriptSegment contract.
- OpenAI Whisper local-inference adapter/bridge.
- Audio cleanup after successful local transcription.

## Non-goals

No cloud upload, backend audio storage, remote transcription, WebSocket streaming, or durable raw-audio persistence. Local Whisper transcription is explicitly in scope.

## Gate

CP-4 completes only when Gate 4 Audio Capture Accepted passes.
