# Gate Plan

## Gate rule

A gate is a hard stop. The next checkpoint should not be considered complete, and the dependent checkpoint should not be merged, until the gate passes or an explicit exception is documented.

## Gate 0: Repo Safe

Required before CP-1 build work.

Pass criteria:

```text
Unsafe upstream deploy/release workflows disabled.
README identifies the project and upstream source.
Project docs exist.
No application code changed.
develop branch protection reviewed or explicitly deferred.
Issues/project tracking reviewed or explicitly deferred.
```

## Gate 1: Builds Clean

Required before UI changes.

Pass criteria:

```text
Fresh clone builds the web target.
Toolchain version is documented.
Build command is documented.
Known warnings are captured.
CI build path exists or is deliberately deferred.
```

## Gate 2: UI Shell Accepted

Required before notebook/audio capture work is accepted.

Pass criteria:

```text
Split-pane shell works.
Existing notebook drawing remains usable.
Right Generated Notes placeholder renders.
Toolbar/layout remains usable.
Tablet/laptop widths are checked.
Right pane does not intercept notebook input.
No backend, audio, or network behavior is introduced.
```

## Gate 3: Notebook Capture Accepted

Required before audio/transcription work is accepted.

Pass criteria:

```text
Capture Session produces a stable session ID.
Native Butterfly notebook bytes are captured.
Current page ID is correct.
Ordered page list is present.
Page-transition observation records coarse page timing.
Repeated captures retain the same session identity.
Capture does not mutate visible notebook content.
No backend/API key/auth/storage dependency is introduced.
CI passes.
```

## Gate 4: Audio Capture and Local Transcription Accepted

Required before backend contract work.

Pass criteria:

```text
Microphone permission request occurs only after Record.
Permission denial produces a useful error state.
Record starts local browser capture.
Stop ends capture and releases microphone tracks.
Local OpenAI Whisper companion health check works.
Loopback-only transcription endpoint is enforced.
Timestamped transcript output is produced locally.
Temporary companion audio file is deleted.
Frontend in-memory audio bytes are discarded after transcription/failure.
Notebook drawing/navigation remains usable while recording.
No lecture audio leaves the instructor device.
No cloud transcription endpoint is present.
CI passes.
```

## Gate 5: Backend Contract Accepted

Required before generated-output work.

Pass criteria:

```text
Frontend creates a session through the API.
Notebook/session manifest can be submitted.
Timestamped local transcript can be submitted.
Raw lecture audio is absent from the default request.
No transcription provider credential is present in the frontend.
Fake generation job returns status updates.
Sample PDF/output metadata can be returned.
Network failures are visible and retryable.
Backend boundary does not change local audio cleanup behavior.
CI passes.
```

## Gate 6: Generated Output Viewer Accepted

Required before alpha demo work.

Pass criteria:

```text
Right pane loads backend-produced sample PDF/output metadata.
Loading, failed, complete, and stale states are visible.
Previous generated output is not lost on failed regeneration.
Version label is visible.
Download path exists or is clearly stubbed.
CI passes.
```

## Gate 7: External Alpha Readiness

Required before external users.

Pass criteria:

```text
Source Code link exists in deployed frontend.
AGPL source availability path works.
Audio/privacy notice exists.
Raw audio non-retention policy is documented.
Transcript retention policy is documented.
Known failure modes are documented.
Legal review is complete or explicitly scheduled before launch.
Manual end-to-end instructor workflow passes.
```
