# Current Project Status

Date: 2026-09-18
Branch context: `project/cp-4-audio-capture`

## Active PR stack

```text
develop
  -> PR #4 / CP-2 Split-Pane Lecture Shell
      -> PR #5 / CP-3 Notebook Session Capture
          -> PR #6 / CP-4 Local Audio + Whisper Transcription
```

## CP-2: Split-Pane Lecture Shell

Status: implementation present; Gate 2 remains open until clean CI and manual browser validation.

Scope:

```text
Butterfly notebook/editor on the left
Generated Notes panel on the right at expanded widths
no backend
no audio
no PDF generation
minimal composition change around existing editor runtime
```

Gate 2 requires browser validation of drawing, touch/pan/zoom, keyboard shortcuts, page navigation, responsive layout, and ensuring the right pane does not intercept notebook input.

## CP-3: Notebook Session Capture

Status: implementation complete; Gate 3 remains open until clean CI and manual capture validation.

Implemented:

```text
LectureSessionManifest
LecturePageManifest
LectureCaptureBundle
LectureCaptureService
native Butterfly notebook serialization
stable session identity
DocumentBloc page-transition observation
coarse page active-from / active-to timing
local Capture Session inspection
manifest/session tests
```

No backend, audio, transcription, storage, AI, or auth is introduced in CP-3.

## CP-4: Local Audio + Whisper Transcription

Status: first local capture-to-transcript path implemented; Gate 4 remains open until clean CI and browser/local-companion validation.

Implemented:

```text
AudioCaptureArtifact
AudioCaptureService
browser MediaRecorder implementation
AudioControls in the lecture panel
LocalTranscript
TranscriptSegment
LocalTranscriptionService
loopback-only LocalWhisperHttpTranscriptionService
local FastAPI/OpenAI Whisper companion
frontend in-memory audio discard
companion temporary-file cleanup
runbook and gate documentation
```

Required policy:

```text
browser microphone
  -> temporary local audio
  -> local OpenAI Whisper transcription
  -> timestamped transcript
  -> delete/release temporary audio
```

Raw lecture audio is not a durable product artifact and is not uploaded to the backend in the default design.

## CP-5: Transcript-First Backend Contract

Planned next after Gate 4.

Backend inputs should be:

```text
LectureSessionManifest
Butterfly notebook artifact or selected page renderings
LocalTranscript + timestamped segments
course/profile identifier
instructor generation instruction
```

Raw microphone audio is excluded from the default backend request.

## Immediate next actions

```text
1. Wait for clean CI on CP-2/CP-3/CP-4 branch heads.
2. Perform Gate 2 browser interaction checks.
3. Merge CP-2, then retarget CP-3 to develop.
4. Perform Gate 3 local Capture Session checks.
5. Merge CP-3, then retarget CP-4 to develop.
6. Run the local Whisper companion and perform Gate 4 microphone/transcript cleanup checks.
7. Start CP-5 only after Gate 4 passes.
```
