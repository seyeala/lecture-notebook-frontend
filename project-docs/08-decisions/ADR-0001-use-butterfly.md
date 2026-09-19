# ADR-0001: Use Butterfly as the Frontend Base

## Status

Accepted.

## Context

The product needs a polished notebook layer with stylus handwriting, pages, layers, shapes, text, images, PDF/SVG support, templates, web support, and export behavior.

Building this notebook layer from scratch would dominate the MVP schedule and distract from the actual differentiator: lecture audio plus handwritten context plus course prompt producing polished LaTeX/PDF notes.

## Decision

Use `LinwoodDev/Butterfly` as the frontend base.

## Consequences

Positive:

```text
Notebook feature set exists immediately.
Flutter web path exists.
Stylus/touch/mouse drawing exists.
PDF/image/SVG import/export paths exist.
Pages, templates, layers, and document concepts already exist.
```

Negative:

```text
The modified frontend is AGPL-3.0.
The team must work inside a Flutter/Dart codebase.
Frontend source availability must be handled before external deployment.
```

## Alternatives considered

```text
Quickdraw: permissive MIT SDK, but requires building more notebook features.
Excalidraw: mature MIT whiteboard, but less notebook/document oriented.
tldraw: technically strong, but not suitable for a free/open production base under this project strategy.
Build from scratch: rejected for MVP due to schedule and quality risk.
```
