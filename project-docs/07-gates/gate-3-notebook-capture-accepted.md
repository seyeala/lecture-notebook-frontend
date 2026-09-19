# Gate 3: Notebook Capture Accepted

## Automated criteria

- [ ] Frontend Build Baseline passes.
- [ ] Dart quality passes.
- [ ] Inherited Flutter build passes.
- [x] Capture models serialize without adding a backend dependency.
- [x] No API key, backend URL, auth, or upload code is introduced.

## Manual criteria

- [ ] Existing notebook editing remains usable.
- [ ] Capture Session produces a session ID.
- [ ] Capture produces non-empty notebook bytes.
- [ ] Current page ID is correct.
- [ ] Ordered page list is present.
- [ ] Repeated captures retain the same session ID.
- [ ] Changing page updates observed activity metadata.
- [ ] Capture does not mutate visible notebook content.

## Pass rule

Gate 3 passes only after automated CI and local capture inspection succeed.
