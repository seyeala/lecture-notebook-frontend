# ADR-0006: Compose the split pane around the existing editor

Status: accepted for CP-2.

## Context

Butterfly's ProjectPage owns complex document and editor runtime behavior. A deep refactor during the first product UI checkpoint would increase regression and upstream-sync risk.

## Decision

Introduce a small `LectureShell` and static `GeneratedNotesPanel`. Wrap the existing editor body rather than moving or rewriting document/runtime logic.

At expanded widths the shell uses an approximately 65/35 split. At narrower widths it returns the existing notebook unchanged.

## Consequences

This minimizes CP-2 risk and keeps upstream synchronization tractable. More advanced pane state, resizing, compact navigation, and PDF rendering are deferred.
