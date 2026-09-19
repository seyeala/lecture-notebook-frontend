# Chunked Local Transcription Plan

The first CP-4 implementation records MediaRecorder chunks every five seconds but combines them into a single artifact at Stop. This is sufficient to prove the permission, recording, localhost transcription, and cleanup boundary.

Production lectures require bounded processing.

## Target design

```text
MediaRecorder
  -> bounded chunk window (for example 30-60 s)
  -> small overlap window
  -> localhost Whisper
  -> timestamp offset normalization
  -> append transcript segments
  -> zero/discard processed audio
```

## Requirements

- Never retain the complete lecture recording by default.
- Keep only a bounded amount of raw audio in memory.
- Add absolute session offsets to local Whisper segment timestamps.
- Preserve page-activity timestamps from CP-3.
- Deduplicate overlapping transcript text/segments.
- Backpressure recording/transcription if local inference falls behind.
- Surface local transcription lag without stopping notebook editing.
- Do not send chunks to a non-loopback endpoint.

## Gate strategy

The basic local capture-to-transcript lifecycle belongs to Gate 4. Sustained bounded-memory transcription for a representative full lecture is a production-readiness criterion before external classroom pilots.
