# Notebook Capture Contract

CP-3 defines a frontend-local capture boundary for future backend upload.

## Contract

`LectureSessionManifest` contains:

- schema version
- local session ID
- session creation time
- capture time
- document name
- current page ID
- ordered page manifests

Each `LecturePageManifest` contains a page ID, page index, first-observed activity time, and last-left time when known.

`LectureCaptureBundle` contains the manifest plus Butterfly's serialized notebook bytes.

## Source of notebook bytes

Capture calls `DocumentLoaded.saveData()` and then `NoteData.exportAsBytes()`. This reuses Butterfly's document serialization rather than introducing another notebook serializer.

## Current limitation

Page activity is observed only while the CP-3 service sees page state. Pages that have not been observed during the lecture session receive the session creation time as a conservative fallback. Fine-grained stroke timestamps and visual page rendering are deferred.

## Network boundary

CP-3 performs no HTTP request and has no API URL, credential, or backend dependency.
