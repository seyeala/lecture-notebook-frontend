# ADR-0003: Keep Backend Separate from the AGPL Frontend

## Status

Accepted.

## Context

The frontend is derived from Butterfly and inherits AGPL-3.0 obligations. The project also needs proprietary backend behavior, including AI orchestration, prompt/profile management, transcription routing, LaTeX compile/repair, billing, storage policy, and analytics.

## Decision

Keep the backend separate from the modified Butterfly frontend. Communicate over HTTP, WebSocket, or Server-Sent Events.

## Frontend boundary

Allowed in frontend:

```text
UI controls.
Notebook artifact export.
Audio recording UI.
API client.
Job status display.
Generated PDF viewer.
Source-code link.
```

Not allowed in frontend:

```text
Secrets.
Model provider keys.
Private prompt chains.
Model routing.
Billing rules.
Course-context retrieval logic.
LaTeX compile orchestration.
Storage credentials.
```

## Consequences

Positive:

```text
Frontend AGPL obligations are easier to isolate.
Backend business logic can evolve separately.
Security risk from client-side secrets is reduced.
```

Negative:

```text
The API contract must be carefully designed.
Legal review is still required before launch.
The frontend cannot assume direct access to backend internals.
```
