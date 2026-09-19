# CP-5: Transcript-First Backend Contract

Planned after Gate 4.

## Purpose

Introduce the first remote backend boundary without uploading raw lecture audio.

## Frontend inputs

```text
LectureSessionManifest
Butterfly notebook artifact / selected page renderings
LocalTranscript + timestamped segments
course/profile identifier
instructor generation instruction
```

Raw microphone audio is excluded from the default backend request.

## Initial endpoints

```text
POST /sessions
POST /sessions/{id}/capture
POST /sessions/{id}/generate
GET  /jobs/{id}
GET  /jobs/{id}/events
GET  /outputs/{id}
```

The capture request should carry the notebook/session artifacts and transcript metadata. It must not include raw audio unless a future explicit opt-in product requirement changes the retention policy.

## First implementation

Use a fake/minimal backend first. Prove request serialization, job status, failure handling, and a returned sample PDF before adding model orchestration.

## Gate

Gate 5 Backend Contract Accepted.
