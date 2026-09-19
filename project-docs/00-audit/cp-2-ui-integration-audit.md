# CP-2 UI Integration Audit

Date: 2026-09-19
Branch: `project/cp-2-split-pane-shell`

## Structural finding

The existing `ProjectPage` owns document loading, DocumentBloc, TransformCubit, EditorController, import/export services, focus, shortcuts, and viewport behavior. CP-2 therefore uses a minimal composition seam: the existing `_MainBody` is passed to `LectureShell`. Runtime setup is unchanged.

## Diff review

The product-code delta remains intentionally small. No DocumentBloc, EditorController, import/export, persistence, dependency, backend, or network changes are introduced by CP-2.

The responsive shell uses the pinned Butterfly expanded breakpoint (1200 logical pixels), a 320-pixel minimum notes pane, and a one-pixel divider. The resulting minimum split width is 1521 logical pixels. Earlier documentation that described a 1000-pixel split was stale and has been corrected in the project documentation.

The notebook remains under the same `Row -> Expanded` widget path before and after the notes pane appears. This avoids disposing and recreating notebook-local widget state solely because the window crossed the split breakpoint.

## Automated evidence

Head `3cec4d3e7086b1678c41c76e1ea16eb42c6298ce` reached the following current-head checks before the short-height fix was added:

```text
Dart quality: PASS, run 35425555346
  app formatting: PASS
  app analyzer: PASS
  app Flutter tests: PASS
Frontend Build Baseline: PASS, run 35425555351
Inherited Flutter build: still running when this head was superseded
```

A fresh isolated clone of `3cec4d3e7086b1678c41c76e1ea16eb42c6298ce` used Flutter 3.47.4 / Dart 3.13.3. The full focused repository widget-test invocation initially failed because the isolated environment lacked Rust tooling. After installing minimal rustup locally, the retry was terminated with exit 137 while cleaning `build/unit_test_assets`; this local attempt is not passing gate evidence. GitHub CI's app Flutter-test step on run `35425555346` did pass.

## Short-height regression and fix

The Generated Notes placeholder originally centered a fixed-height content column directly inside the available body height. A minimal Flutter harness reproduced a real layout failure at a 600x240 logical-pixel viewport:

```text
A RenderFlex overflowed by 221 pixels on the bottom.
```

The fix wraps the body in a vertically scrollable constrained region while preserving centered content when sufficient height is available. The same minimal Flutter harness passes after the fix. A repository regression test now asserts that the panel does not overflow at the short-height viewport and that the scroll container is present.

Fix commits:

```text
50176ad543c6fad7f6789e100b1b651ea909b2fd  CP-2: prevent short-height notes overflow
9f8ad6f7cc0f1a7ad64af3acb7f1ae911cbe0c95  CP-2: add short-height panel regression test
```

Current-head workflows for `9f8ad6f7cc0f1a7ad64af3acb7f1ae911cbe0c95` are pending and must pass before automated Gate 2 evidence is current again.

## Interaction risk

The Generated Notes panel is a sibling of the notebook region rather than an overlay, so it should not receive pointer events inside the notebook's allocated region. Widget tests cover full-width behavior below the split threshold, notebook state preservation while crossing the threshold, notes sizing at a wide viewport, and the short-height overflow regression. These automated checks do not replace browser/device interaction testing.

## Remaining Gate 2 evidence

- Successful current-head CI on `9f8ad6f7cc0f1a7ad64af3acb7f1ae911cbe0c95`.
- Browser opens editor successfully.
- Pen/stylus and mouse drawing.
- Touch pan/zoom on a target touch device.
- Keyboard shortcuts.
- Page navigation.
- Generated Notes placeholder at or above the 1521 logical-pixel split threshold.
- Full-width notebook below the split threshold.
- Right pane does not intercept notebook input.
- Representative laptop/tablet-landscape layout.

## Audit decision

```text
Code-scope audit: PASS
Architecture-boundary audit: PASS
Short-height overflow: REPRODUCED AND FIXED; minimal harness PASS
Current-head CI: PENDING
Manual interaction audit: PENDING
Gate 2 overall: PENDING
```
