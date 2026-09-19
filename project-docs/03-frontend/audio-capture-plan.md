# Audio Capture Plan

CP-4 introduces local lecture-audio capture as a separate boundary from notebook capture.

## Architecture

```text
AudioControls
    ↓
AudioCaptureService interface
    ↓
web media implementation
    ↓
AudioCaptureArtifact
```

The artifact records bytes, MIME type, start time, end time, and derived duration.

## Browser implementation

The web implementation should request microphone permission only when Record is pressed, collect audio locally, stop all media tracks when recording ends, and return an in-memory artifact. No audio upload is permitted in CP-4.

## Format policy

Prefer a browser-supported compressed audio format such as WebM/Opus. The implementation must record the actual MIME type rather than assuming one.

## Failure policy

Permission denial, unsupported browser APIs, recorder failure, and empty recordings must become explicit UI states and must not affect notebook data.

## Local transcription and audio-retention policy

CP-4 does not treat recorded audio as a durable application asset. Audio is an ephemeral input to local speech-to-text.

The target transcription engine is OpenAI Whisper running locally. OpenAI's Whisper code and model weights are MIT-licensed, and the upstream implementation accepts local audio files/waveforms and supports timestamped transcription. The initial reference implementation should use the official `openai/whisper` project or a separately reviewed local runtime that preserves the same privacy boundary.

Target lifecycle:

```text
microphone
  -> short-lived local audio buffer/file
  -> local Whisper transcription
  -> timestamped transcript segments
  -> discard audio after successful transcription
```

No lecture audio is uploaded to our backend or retained in cloud/object storage by default. The transcript, timing metadata, and explicit transcription diagnostics become the durable lecture artifacts. A temporary local audio file may exist only as required by the browser/native bridge or Whisper/FFmpeg processing and must be deleted after successful transcription or explicit cancellation/cleanup.

For crash recovery, any future temporary retention must be explicit, bounded, local-only, documented, and user-controllable; it is not part of CP-4.

Whisper model weights may require a one-time local download/cache. Model files are not lecture data and can remain cached locally.
