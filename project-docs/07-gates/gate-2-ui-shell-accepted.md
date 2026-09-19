# Gate 2: UI Shell Accepted

Gate 2 is the hard stop between the layout feasibility work and session/export work.

## Automated criteria

- [ ] Frontend Build Baseline passes.
- [ ] Dart quality passes.
- [ ] Inherited Flutter build passes.
- [ ] No backend/API/secrets introduced.

## Manual interaction criteria

- [ ] Existing Butterfly editor opens.
- [ ] Pen/stylus drawing remains usable.
- [ ] Mouse drawing remains usable.
- [ ] Touch pan/zoom remains usable on a target touch device.
- [ ] Keyboard shortcuts remain usable.
- [ ] Page navigation remains usable.
- [ ] Generated Notes placeholder appears at expanded width.
- [ ] Notebook remains full width below the CP-2 breakpoint.
- [ ] Right pane does not intercept input over the notebook.
- [ ] Layout is acceptable at representative laptop and tablet-landscape widths.

## Pass rule

Automated CI success is necessary but not sufficient. Gate 2 remains pending until the manual interaction criteria are checked on a browser with the editor loaded.
