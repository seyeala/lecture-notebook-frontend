# CP-5: Transcript-First Backend Contract

Planned after Gate 4.

## Purpose

Introduce the first remote backend boundary without uploading raw lecture audio by default.

CP-5 is a contract checkpoint, not a full AI-generation checkpoint. It proves request shape, job lifecycle, status updates, and returned sample output before model orchestration is added.

## Frontend inputs

```text
LectureSessionManifest
native Butterfly notebook artifact or selected page renderings
LocalTranscript + timestamped segments
course/profile identifier
instructor generation instruction
```

Raw microphone audio is excluded from the default backend request.

## Explicitly excluded

```text
raw microphone audio upload
microphone chunk upload
cloud transcription provider credential
remote speech-to-text request
model orchestration secrets in frontend
production billing/auth complexity
```

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

Use a fake/minimal backend first. Prove:

```text
frontend request serialization
payload inspection
job creation
job status updates
failure handling
sample output metadata
sample returned PDF
```

Do not add model orchestration until the backend boundary and privacy contract are accepted.

## Privacy acceptance check

Gate 5 fails if the default flow uploads or persists raw microphone audio. The backend may receive local transcript segments and timing metadata, because those are the durable semantic lecture artifacts.

## Gate

Gate 5 Backend Contract Accepted.
