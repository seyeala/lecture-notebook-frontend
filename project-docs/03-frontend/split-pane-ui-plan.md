# Split-Pane UI Plan

CP-2 introduces the first product-specific UI composition while preserving Butterfly's editor runtime.

## Design

The split appears only when the workspace can keep the Butterfly notebook at its existing expanded breakpoint while also allocating a useful notes pane. With the currently pinned `material_leap` breakpoints this is:

```text
1200 logical pixels notebook + 1 pixel divider + 320 pixel notes minimum
= 1521 logical pixels minimum split width
```

Below 1521 logical pixels the existing notebook remains full width. At and above the split threshold, the Generated Notes pane prefers approximately 35% of the workspace but is capped so the notebook never falls below Butterfly's 1200-pixel expanded breakpoint.

CP-2 deliberately avoids a compact-screen notes drawer or toggle.

## Integration boundary

The existing `ProjectPage` continues to own document loading, blocs/cubits, import/export services, keyboard shortcuts, focus, and the editor viewport. The new `LectureShell` wraps only the existing `_MainBody`.

`LectureShell` keeps a stable `Row -> Expanded -> notebook` widget path on both sides of the responsive threshold. Only the divider and Generated Notes sibling are inserted or removed. This prevents the shell itself from disposing and recreating notebook-local widget state during a resize.

No backend, audio capture, PDF renderer, session model, or network client is introduced.

## Input safety

The generated-notes panel is a sibling of the notebook region, not an overlay. This avoids intercepting pointer events over the notebook canvas.

## Deferred

Resizable divider, persistent pane width, compact notes toggle, real PDF rendering, generation controls, audio controls, and job status are deferred.
