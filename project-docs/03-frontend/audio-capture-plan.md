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
