# Backend Boundary

## Decision

The modified Butterfly frontend and the AI backend must remain separate systems.

```text
Frontend:
  AGPL-3.0 modified Butterfly code.

Backend:
  Separate proprietary services communicating over HTTP, WebSocket, or Server-Sent Events.
```

## Frontend may contain

```text
Split-pane layout.
Notebook canvas integration.
Audio recording UI.
Upload client code.
Generate/update controls.
Job status display.
PDF viewer.
Source-code link for AGPL compliance.
Configuration for public API base URL.
```

## Frontend must not contain

```text
API keys.
Secret prompts.
Model routing logic.
Billing logic.
Private analytics logic.
Course-context retrieval policy.
LaTeX compile orchestration.
Storage credentials.
Transcription provider credentials.
```

## Backend owns

```text
Authentication.
Storage.
Transcription.
AI orchestration.
Prompt/profile resolution.
LaTeX generation.
Compile/repair loop.
Generated asset versioning.
Billing and usage metering.
Private course context handling.
```

## API boundary

The frontend should communicate through a narrow API contract:

```text
POST /sessions
POST /sessions/{id}/assets
POST /sessions/{id}/audio
POST /sessions/{id}/generate
GET  /jobs/{id}
GET  /jobs/{id}/events
GET  /outputs/{id}/pdf
GET  /outputs/{id}/tex
```

This contract will be formalized after CP-3 session capture and before real AI integration.
