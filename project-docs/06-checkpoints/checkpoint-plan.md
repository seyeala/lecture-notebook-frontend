# Checkpoint Plan

## How checkpoints work

A checkpoint is a bounded work package. Each checkpoint has deliverables and a corresponding gate. The gate decides whether the next checkpoint may begin.

## CP-0: Fork Stabilization

Purpose: make the fork safe to modify.

Deliverables:

```text
Project docs created.
README revised.
Unsafe upstream workflows disabled.
Branch strategy documented.
AGPL/source-boundary notes documented.
First ADRs written.
```

Gate: Gate 0 Repo Safe.

## CP-1: Build Baseline

Purpose: prove the fork builds before product changes.

Deliverables:

```text
Fresh clone build instructions.
Flutter/Dart toolchain version captured.
Web build command documented.
Build warnings/errors captured.
CI build workflow selected or adapted.
```

Gate: Gate 1 Builds Clean.

## CP-2: Split-Pane Shell

Purpose: prove UI integration feasibility.

Deliverables:

```text
Left pane keeps existing Butterfly notebook behavior.
Right pane displays a Generated Notes placeholder.
Expanded-width split layout.
Compact-width notebook-only fallback.
No backend integration.
No audio/transcription.
```

Gate: Gate 2 UI Shell Accepted.

## CP-3: Notebook Session Capture

Purpose: prove the frontend can produce a local notebook/session capture bundle without a backend.

Deliverables:

```text
LectureSessionManifest.
LecturePageManifest.
LectureCaptureBundle.
Stable session ID.
Native Butterfly notebook bytes.
Current page ID.
Ordered page list.
DocumentBloc page-transition observation.
Coarse page active-from / active-to timing.
Local Capture Session inspection.
Focused manifest/session tests.
```

Gate: Gate 3 Notebook Capture Accepted.

## CP-4: Local Audio and Whisper Transcription

Purpose: record lecture audio locally, transcribe it locally, retain only the transcript/timing metadata, and discard temporary audio.

Deliverables:

```text
AudioCaptureArtifact.
Browser MediaRecorder capture.
Record/Stop controls.
Duration/status UI.
LocalTranscript.
TranscriptSegment.
LocalTranscriptionService.
Loopback-only LocalWhisperHttpTranscriptionService.
Local FastAPI + OpenAI Whisper companion.
Temporary OS audio cleanup in companion.
Frontend in-memory byte discard.
Local companion runbook.
Chunked transcription production plan.
```

Gate: Gate 4 Audio Capture Accepted.

## CP-5: Transcript-First Backend Contract

Purpose: connect frontend to a fake/minimal backend using transcript-first lecture artifacts, without uploading raw audio by default.

Default backend payload:

```text
LectureSessionManifest.
Native Butterfly notebook artifact or selected page renderings.
LocalTranscript with timestamped segments.
Course/profile identifier.
Instructor generation instruction.
```

Explicitly excluded by default:

```text
raw microphone audio
microphone chunks
cloud transcription credential
remote speech-to-text request
```

Deliverables:

```text
POST /sessions.
POST /sessions/{id}/capture.
POST /sessions/{id}/generate.
GET /jobs/{id}.
GET /jobs/{id}/events.
GET /outputs/{id}.
Fake/minimal generation job.
Sample returned PDF/output metadata.
Request inspection proving raw audio is absent.
```

Gate: Gate 5 Backend Contract Accepted.

## CP-6: Generated PDF Viewer

Purpose: make the right pane consume backend-produced output robustly.

Deliverables:

```text
Load PDF/output metadata from backend URL.
Show loading, failed, complete, and stale states.
Download current PDF.
Display version label.
Do not lose previous PDF on failed regeneration.
```

Gate: Gate 6 Generated Output Viewer Accepted.

## CP-7: Alpha Demo

Purpose: prove the controlled end-to-end instructor workflow.

Deliverables:

```text
Instructor writes notes.
Instructor records and locally transcribes audio.
Instructor clicks Generate.
Backend receives notebook/session/transcript artifacts.
Backend returns generated PDF.
Right pane displays PDF.
Source Code link is visible.
Download PDF/TEX/transcript/logs path exists or is stubbed.
```

Gate: Gate 7 External Alpha Readiness.
