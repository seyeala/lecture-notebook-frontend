# CP-3 Capture Design Audit

Date: 2026-09-18

## Existing seam

Butterfly's loaded document state already exposes `saveData()` and `saveBytes()`. CP-3 reuses this existing serialization path instead of implementing a second notebook serializer.

The existing `ExportService` is element-oriented, while full-document export actions use loaded document state. Therefore the CP-3 capture service correctly uses the document-state serialization seam for the source notebook artifact.

## Boundary review

CP-3 adds local models, local capture service, and local inspection UI only.

No backend, network client, authentication, storage provider, AI provider, transcription, or LaTeX compiler is introduced.

## Known limitation

The first implementation captures the native notebook bytes as the required visual/source artifact. Page-image/PDF rendering is deferred until the exact AI ingestion format is selected, avoiding premature duplicate rendering code.


## Refinement after audit

The initial implementation observed the active page only when Capture Session was invoked. That was insufficient for lecture timing.

The editor now listens for `DocumentBloc` page-name transitions and calls `LectureCaptureService.observePage(pageName)`. This records coarse page-entry/page-exit timing while the instructor navigates.

Focused tests were also added for manifest JSON serialization, non-empty bundle byte handling, stable session identity, and session identity across page observations.

CI and manual capture validation remain required before Gate 3 passes.


## Final implementation status

The CP-3 implementation now includes continuous page-change observation, native Butterfly notebook serialization, stable session identity, manifest serialization tests, and bundle-byte tests. Frontend Build Baseline passed on the prior head. The remaining automated blocker was Dart formatter indentation in `lecture_capture.dart`; that exact formatter output has now been applied. A fresh CI run is required before automated Gate 3 closure. Manual Capture Session validation remains required.
