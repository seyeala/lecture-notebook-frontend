# Gate 4: Audio Capture Accepted

## Automated criteria

- [ ] Frontend Build Baseline passes.
- [ ] Dart quality passes.
- [ ] Flutter build passes.
- [ ] Audio artifact/lifecycle tests pass.
- [ ] No backend/upload code is introduced.
- [ ] LocalTranscriptionService contract is used for transcription runtime isolation.
- [ ] No cloud transcription endpoint is present.

## Browser criteria

- [ ] Microphone permission request occurs only after Record.
- [ ] Permission denial produces a useful error state.
- [ ] Record starts capture.
- [ ] Stop ends capture and releases microphone tracks.
- [ ] Non-empty local audio artifact is produced.
- [ ] Actual MIME type is retained.
- [ ] Duration is retained.
- [ ] Notebook drawing/navigation remains usable while recording.
- [ ] Audio failure does not alter notebook data.
- [ ] No lecture audio leaves the instructor device.
- [ ] Local transcription produces timestamped transcript output.
- [ ] Temporary audio is deleted/released after successful transcription.
- [ ] Cleanup failure is surfaced as a privacy-relevant error/warning.

## Pass rule

Gate 4 requires clean CI and browser testing on at least one Chromium-based target browser.
