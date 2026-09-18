# AGPL Compliance Plan

## Scope

This document covers the modified frontend derived from Butterfly.

## Current license posture

```text
Frontend base: LinwoodDev/Butterfly
Frontend license: AGPL-3.0
Project fork: seyeala/lecture-notebook-frontend
Backend services: separate repositories/services, not part of this fork
```

## Working rule

During private development, this fork can remain controlled by the project owner. Before external users interact with a deployed modified frontend over a network, users must have a clear path to obtain the corresponding frontend source code.

## Required frontend controls before external alpha

```text
Visible Source Code link in the running app.
Public source repository or source archive for the exact deployed frontend version.
License notices retained.
Build instructions documented.
Third-party license notes reviewed.
No backend secrets embedded in frontend code.
```

## Backend separation rule

Keep proprietary backend code and private business logic out of the AGPL frontend repository. The backend can communicate with the frontend over HTTP, WebSocket, or Server-Sent Events.

## Legal review

Legal review is required before charging customers, deploying to external users, or making claims about the backend remaining proprietary.

## Gate dependency

Gate 5 external-user readiness cannot pass until source availability, license notices, and the frontend/backend boundary are reviewed.
