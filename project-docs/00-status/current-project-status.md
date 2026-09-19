# Current Project Status

Updated: 2026-09-18 project date; associated CI and commits use UTC timestamps on 2026-09-19.
Branch context: `project/cp-4-audio-capture`. Re-fetch GitHub for the latest heads and checks.

## Active stack

```text
develop
  -> PR #4 / CP-2 / project/cp-2-split-pane-shell
      -> PR #5 / CP-3 / project/cp-3-session-capture
          -> PR #6 / CP-4 / project/cp-4-audio-capture
```

The owner has authorized sequential validation and merge into `develop`. Authorization does not mean a gate has passed. Do not merge a child PR into its parent feature branch accidentally.

## Checkpoint status

| Checkpoint | Code status | Validation / merge status |
|---|---|---|
| CP-0 | repository-control changes merged previously | governance settings are separate; do not infer protection from merged docs |
| CP-1 | build workflow/runbooks merged previously | historical baseline evidence exists |
| CP-2 | shell implemented; formatter and short-height fixes committed | Gate 2 open; current Dart quality and frontend baseline pass, inherited Flutter build still pending at latest observation, browser/device interaction evidence still required; not merged |
| CP-3 | capture prototype and tests exist; UTC fixture corrected | Gate 3 open; real capture/lifecycle evidence required; not merged |
| CP-4 | local recording/Whisper prototype exists; native adapter fix committed | Gate 4 open; current CI, transcript retention, companion/privacy and device validation required; not merged |
| CP-5 | transcript-first backend plan only | no new implementation authorized by this continuation task |

Earlier wording that CP-3 or CP-4 was fully complete should not be interpreted as validation. Test files and prototype plumbing are not passing gate evidence.

## Latest CP-2 validation snapshot

Observed against PR #4 head `c4a8fb0e02e0461fce9c3772af8f6dfb821ad231`, base `develop` at `d873e5dd95d1419530bea567b613a32407419c66`.

```text
Dart quality: PASS
  run 35426238809
  app formatting: PASS
  app analyzer: PASS
  build_runner / generated-diff check: PASS
  full app Flutter tests: PASS, 356 tests
  lecture shell tests: all 4 PASS

Frontend Build Baseline: PASS
  run 35426238825

Inherited Flutter build: RUNNING at latest observation
  run 35426238808
```

The PR #4 diff remains limited to the static lecture shell/panel, its tests, the `_MainBody` composition seam, and project documentation. No backend client, API, network call, credential, secret, audio, or transcription code is introduced by CP-2.

An isolated reproduction workspace used Flutter 3.47.4 / Dart 3.13.3 on the exact current head. A focused local `flutter test test/views/lecture/lecture_shell_test.dart` attempt was not a passing result because the local test engine rejected the bundled `ink_sparkle.frag` shader (`Found stages: Vulkan`, current backend expected SkSL). This environment-specific attempt must not be reported as a repository test failure; the GitHub app test job on the same head executed and passed all four lecture-shell tests.

A sandboxed Playwright 1.55.0 / Chromium 140 browser runtime was downloaded for independent browser smoke testing, but the host lacks required Chromium shared libraries (including GLib, NSS, X11/GBM and related libraries) and elevated package installation is unavailable. Therefore this environment cannot supply the Gate 2 browser interaction evidence. It also cannot replace the required real stylus/touch-device checks.

Latest downstream state observed in the same run:

```text
PR #5 / CP-3: open, head 24b7c85999184b81b6b9679fceab747e267a4596, currently reported non-mergeable; still targets CP-2 feature branch.
PR #6 / CP-4: open, head 0e3d6c67c0ad64d0a3d00b812cbaae5449a442a3, reported mergeable; still targets CP-3 feature branch.
```

No PR was merged or retargeted in this snapshot because Gate 2 is still open.

## Recent verified work

- CP-2 exact Dart 3.13.3 formatter output: `c0bee26c0db8b93d74b022e7c2c8db4e429f1c80`.
- CP-2 short-height notes-panel overflow fix and regression coverage are present in current PR #4 head `c4a8fb0e02e0461fce9c3772af8f6dfb821ad231`; focused GitHub CI tests for the shell pass on this head.
- CP-3 independently verified UTC test fixture: `24b7c85999184b81b6b9679fceab747e267a4596`.
- CP-4 native null-safety fix with standalone Dart smoke test: `d22e1ff4728ed6104fb84cd00b6597171d709612`.

See [closure audit](../00-audit/checkpoint-closure-2026-09-18.md) for exact scope and historical run IDs.

## Local-transcription policy

```text
microphone -> temporary audio on instructor device
           -> local OpenAI Whisper inference
           -> retained transcript text and timing metadata
           -> release/delete temporary audio
```

No default remote audio upload or cloud transcription fallback. The current prototype accumulates a recording until Stop; it is not bounded streaming. Zeroing one buffer or deleting one temporary file is not a secure-erasure guarantee for all copies. Validate and document actual cleanup behavior.

## Authorized continuation

Follow [autonomous continuation plan](autonomous-continuation-plan.md). An hourly ChatGPT task checks CI and continues bounded repair/validation work without requiring another general prompt. It must not fabricate device results, waive gates, or expand into production deployment.

Merge order remains CP-2, then CP-3, then CP-4. Retarget and revalidate each child after its parent merges. If a real-device check or unavailable permission is the remaining blocker, report the exact requirement once and hold that transition.

## Next planned checkpoint

CP-5 accepts the notebook/session manifest, visual/source artifacts, timestamped local transcript, course profile, and instructor instructions. Raw microphone audio is excluded from the default remote request. Build a mock job/output boundary before real AI orchestration; do not begin until Gate 4 passes and implementation is authorized.
