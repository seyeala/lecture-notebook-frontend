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
