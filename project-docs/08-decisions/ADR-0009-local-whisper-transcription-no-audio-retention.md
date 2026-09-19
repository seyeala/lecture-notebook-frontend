# ADR-0009: Local Whisper transcription with no durable lecture-audio retention

Status: accepted.

## Decision

Use OpenAI's open-source Whisper models locally for lecture transcription. Recorded lecture audio is ephemeral processing input, not a durable backend asset.

The preferred reference is the official `openai/whisper` implementation, whose code and model weights are MIT-licensed. Alternative runtimes such as faster-whisper or whisper.cpp may be evaluated later for performance, but adopting one requires its own dependency/license/runtime review.

## Data lifecycle

```text
microphone
  -> local temporary audio
  -> local Whisper
  -> timestamped transcript
  -> delete temporary lecture audio
```

Persist:
- transcript text
- segment/word timing where available
- language/model metadata
- transcription warnings/uncertainty metadata

Do not persist by default:
- raw lecture audio
- microphone chunks
- cloud audio copies

## Rationale

The generated-note pipeline needs the semantic transcript and approximate timing alignment, not a permanent audio archive. Local transcription reduces privacy exposure and storage requirements.

## Consequences

CP-4 expands from audio capture alone to local capture-to-transcript lifecycle design. A browser-only Flutter build cannot directly execute the Python/PyTorch Whisper reference implementation; therefore the actual local inference host/bridge must be selected explicitly rather than disguising a remote service as local processing.
