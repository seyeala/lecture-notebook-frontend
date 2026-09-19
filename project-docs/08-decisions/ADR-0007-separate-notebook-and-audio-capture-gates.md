# ADR-0007: Separate notebook and audio capture gates

Status: accepted.

## Decision

CP-3 owns notebook/session capture only. CP-4 owns browser audio capture and receives its own gate.

## Rationale

Notebook serialization/page metadata and browser microphone/media behavior fail for different reasons. Separate gates improve debugging, testing, and rollback while keeping CP-3 backend-free.

## Revised sequence

```text
CP-3 -> Gate 3 Notebook Capture Accepted
CP-4 -> Gate 4 Audio Capture Accepted
CP-5 -> Gate 5 Backend Contract Accepted
```
