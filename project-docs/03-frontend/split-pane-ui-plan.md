# Split-Pane UI Plan

CP-2 introduces the first product-specific UI composition while preserving Butterfly's editor runtime.

## Design

At widths of 1000 logical pixels or more:

```text
Butterfly notebook/editor  |  Generated Notes placeholder
approximately 65%          |  approximately 35%
```

Below 1000 logical pixels the existing notebook remains full width. CP-2 deliberately avoids a compact-screen notes drawer or toggle.

## Integration boundary

The existing `ProjectPage` continues to own document loading, blocs/cubits, import/export services, keyboard shortcuts, focus, and the editor viewport. The new `LectureShell` wraps only the existing `_MainBody`.

No backend, audio capture, PDF renderer, session model, or network client is introduced.

## Input safety

The generated-notes panel is a sibling of the notebook region, not an overlay. This avoids intercepting pointer events over the notebook canvas.

## Deferred

Resizable divider, persistent pane width, compact notes toggle, real PDF rendering, generation controls, audio controls, and job status are deferred.
