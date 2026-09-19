# CP-2 UI Integration Audit

Date: 2026-09-18

## Pre-implementation finding

The existing `ProjectPage` in `app/lib/views/main.dart` owns substantial editor runtime state: document loading, DocumentBloc, TransformCubit, EditorController, import/export services, focus, shortcuts, and viewport behavior.

Therefore CP-2 uses a minimal composition seam: the existing `_MainBody` is passed to a new `LectureShell`. The runtime setup is unchanged.

## Risk controls

- No DocumentBloc changes.
- No EditorController changes.
- No import/export changes.
- No persistence changes.
- No pointer overlay above the notebook.
- No new package dependency.
- No backend/network integration.

## Evidence to record

After CI and manual browser testing, record build results, tested viewport widths, drawing/pan/zoom/page-navigation behavior, and any regression.
