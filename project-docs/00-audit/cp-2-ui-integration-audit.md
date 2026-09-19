# CP-2 UI Integration Audit

Date: 2026-09-18
Branch: `project/cp-2-split-pane-shell`

## Structural finding

The existing `ProjectPage` owns document loading, DocumentBloc, TransformCubit, EditorController, import/export services, focus, shortcuts, and viewport behavior. CP-2 therefore uses a minimal composition seam: the existing `_MainBody` is passed to `LectureShell`. Runtime setup is unchanged.

## Diff review

The product-code delta remains intentionally small. No DocumentBloc, EditorController, import/export, persistence, dependency, backend, or network changes are introduced by CP-2.

The responsive shell now uses the pinned Butterfly expanded breakpoint (1200 logical pixels), a 320-pixel minimum notes pane, and a one-pixel divider. The resulting minimum split width is 1521 logical pixels. Earlier documentation that described a 1000-pixel split was stale and has been corrected.

The notebook remains under the same `Row -> Expanded` widget path before and after the notes pane appears. This avoids disposing and recreating notebook-local widget state solely because the window crossed the split breakpoint.

## CI evidence

Head `ac67a7ccb85958e9459e8d91254e4bc43ed428fe` completed all declared workflows successfully:

```text
Dart quality: PASS, run 35422199482
Frontend Build Baseline: PASS, run 35422199492
Inherited Flutter build: PASS, run 35422199480
```

Those runs validate the pre-regression-test head. The state-preservation/layout regression test added after that head must pass on the new commit before automated Gate 2 evidence is current again.

## Interaction risk

The Generated Notes panel is a sibling of the notebook region rather than an overlay, so it should not receive pointer events inside the notebook's allocated region. The new widget test covers full-width behavior below the split threshold, notebook state preservation while crossing the threshold, and notes sizing at a wide viewport. These automated checks do not replace browser/device interaction testing.

## Remaining Gate 2 evidence

- Successful CI on the state-preservation regression commit.
- Browser opens editor successfully.
- Pen/stylus and mouse drawing.
- Touch pan/zoom on a target touch device.
- Keyboard shortcuts.
- Page navigation.
- Expanded-width placeholder at or above the 1521 logical-pixel split threshold.
- Full-width notebook below the split threshold.
- Representative laptop/tablet-landscape layout.

## Audit decision

```text
Code-scope audit: PASS
Architecture-boundary audit: PASS
Prior-head CI: PASS
Responsive state-preservation fix: IMPLEMENTED; awaiting CI
Manual interaction audit: PENDING
Gate 2 overall: PENDING
```
