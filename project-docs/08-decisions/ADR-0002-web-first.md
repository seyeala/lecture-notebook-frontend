# ADR-0002: Web-First Frontend Target

## Status

Accepted.

## Context

Butterfly can target multiple platforms, but the MVP needs the lowest-friction deployment path for instructors and internal testing.

## Decision

Build the Live Lecture-to-LaTeX Notebook frontend as web-first.

## Meaning

`lecture-notebook-frontend` is the instructor-facing frontend application. The first target is a browser-accessible web app. Future packaging as PWA, desktop, tablet, or native mobile can be evaluated later.

## Consequences

Positive:

```text
Fastest distribution path.
No app store review cycle for MVP.
Browser audio APIs can support recording.
Backend integration is straightforward over HTTP/SSE/WebSocket.
AGPL source link can be exposed directly in app chrome.
```

Negative:

```text
Stylus behavior must be validated in browser environments.
PDF viewing must work well in Flutter web.
Audio permissions vary by browser/device.
Performance must be checked on tablet hardware.
```

## Follow-up

CP-1 must document the Flutter web build path. CP-2 must validate split-pane usability on laptop and tablet screen widths.
