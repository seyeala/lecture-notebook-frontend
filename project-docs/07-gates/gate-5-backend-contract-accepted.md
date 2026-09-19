# Gate 5: Backend Contract Accepted

## Required

- [ ] Frontend creates a session through the API.
- [ ] Notebook/session manifest can be submitted.
- [ ] Timestamped local transcript can be submitted.
- [ ] Raw lecture audio is absent from the default request.
- [ ] No transcription provider credential is present in the frontend.
- [ ] Fake generation job returns status updates.
- [ ] Sample PDF/output metadata can be returned.
- [ ] Network failures are visible and retryable.
- [ ] Backend boundary does not change local audio cleanup behavior.
- [ ] CI passes.

## Hard privacy check

Inspect the request payload/body and object-storage writes. Gate 5 fails if raw microphone audio is uploaded or persisted by the default flow.
