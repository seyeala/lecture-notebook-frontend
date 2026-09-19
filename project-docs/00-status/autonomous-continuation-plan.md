# Autonomous Checkpoint Closure Plan

Authorized by the repository owner on 2026-09-18. Scope: validate, repair, retarget, and merge CP-2, CP-3, and CP-4 in order, without requiring a fresh prompt for each routine step. This file is a handoff, not evidence that any gate passed.

## Scope and stopping point

Use the connected GitHub tools for repository reads and writes. Use an isolated execution workspace for formatting, analysis, tests, browser smoke tests, and local-companion tests when available. Continue only the already approved CP-2/3/4 functionality and related validation/security/documentation repairs. Keep CP-5 as a transcript-first plan until separately authorized for implementation.

Do not deploy, publish releases, provision paid infrastructure, change repository visibility or protection, access credentials, capture a user's microphone without their explicit device interaction, upload lecture audio remotely, or enable a cloud transcription fallback. Preserve Butterfly attribution, license files, and disabled upstream deployment/release workflows.

## Scheduled execution

A ChatGPT task named `Lecture notebook checkpoint closure` checks hourly. It is not a continuously running background process. Each scheduled run must perform a bounded unit of work and record what actually happened. Tool permissions or hardware requirements can block progress; record the precise blocker instead of inventing results.

Before writing, re-fetch the branch head. Do not overlap a foreground edit session or another active checkpoint job. If another writer has moved the head, re-read and reconcile before committing. Use a single controlled commit for related changes where practical; avoid repeated speculative edits and CI churn. If a lease is needed, record a short-lived run ID, scope, start time, and expiry in the status ledger; never treat an expired lease as approval to overwrite another writer's work.

## PR sequence

| Checkpoint | PR | Head branch | Final merge target |
|---|---|---|---|
| CP-2 | #4 | `project/cp-2-split-pane-shell` | `develop` |
| CP-3 | #5 | `project/cp-3-session-capture` | `develop`, after CP-2 |
| CP-4 | #6 | `project/cp-4-audio-capture` | `develop`, after CP-3 |

The downstream PRs currently target parent feature branches. Never merge a downstream PR into its feature-parent by accident. After a parent merges, retarget the child to `develop`, reconcile any parent changes, inspect the complete diff again, and run validation against the new integration result.

Prefer history-preserving merges while this stack exists. If a squash merge has already changed ancestry, use a reviewed merge/cherry-pick reconciliation on an isolated branch; do not solve it by force-pushing or overwriting a complete tree blindly. Compare parents and preserve all approved fixes.

## Per-run procedure

1. Read this file, `current-project-status.md`, the checkpoint-specific gate, and the newest evidence ledger. Re-fetch PR state, head/base SHA, reviews, changed paths, CI attempts, and check results. Old green runs are historical evidence only.
2. Work on the earliest blocked checkpoint. Inspect the first real failure in job logs; do not infer a failed test from a formatter error or assume skipped tests passed.
3. Reproduce the failure using the pinned toolchain when available. Run the actual Dart formatter; never guess its output. Add regression tests for logic fixes. Keep test strength and CI checks intact.
4. Validate the isolated change. Distinguish source inspection, dependency-light smoke tests, full Flutter tests, browser automation, and real-device tests. Save commands, versions, exit codes, logs, exact tested SHAs, and limitations.
5. Commit through the authorized GitHub connection, then verify the returned branch head and diff. A successful local commit or a denied terminal push is not a GitHub update.
6. If CI is still running, record that state and end the run. Do not repeatedly poll without making progress and do not label pending checks successful.
7. Merge only after every applicable gate item has evidence and every required current-head/integration check passes. Re-fetch the head immediately before calling the merge API with `expected_head_sha`; stop if it moved or if GitHub reports a conflict or required review.
8. Update the ledger and status after a merge, then retarget the next PR. Disable the scheduled task once CP-2/3/4 are all validated and merged. Finish with the CP-5 plan, not unapproved feature implementation.

## Validation worklist

### CP-2: editor shell

The former formatting failure in `lecture_shell.dart` was reproduced with Dart 3.13.3; exact formatter output was committed as `c0bee26c0db8b93d74b022e7c2c8db4e429f1c80`.

Still verify that the editor opens, page navigation/undo/shortcuts work, and resizing across the 1000-logical-pixel breakpoint preserves notebook/viewport state. Inspect fullscreen, presentation, embedded, and hidden-UI modes before declaring no regressions. Test short-height layout and pointer isolation. Real stylus pressure and touch-device checks must be recorded separately from synthetic pointer tests.

### CP-3: notebook/session capture

The deterministic UTC fixture for `2026-09-18T18:00:00Z` is `1789754400000000` microseconds, verified using Dart 3.13.3. The corrected test is committed as `24b7c85999184b81b6b9679fceab747e267a4596`. The formatter puts the `activeTo` conditional on one line; constructor indentation was not the root cause.

Review analyzer output after formatting passes. Validate the initial active page, repeated page visits, document switching/session reset, errors, and late capture completion after navigation. Do not invent activity times for unobserved pages. Test actual notebook serialization and re-import, not only arbitrary byte arrays. Retain or expose the captured manifest/native notebook for inspection instead of only displaying a byte-count summary. Native notebook bytes are a source artifact, not proof of a rendered image/PDF ingestion path; record the visual-export gap honestly.

### CP-4: local Whisper

The native build failure `UnsupportedError(errorMessage)` used a nullable string. The fix uses a local non-null constant and passed a dependency-light Dart regression against the actual adapter source. It is committed as `d22e1ff4728ed6104fb84cd00b6597171d709612`; the full native/Flutter suite still must rerun.

Run the real formatter across audio source, `main.dart`, and tests. Review and test microphone lifecycle, repeated Start, Stop/Dispose races, conversion errors/timeouts, route changes, and a reachable Stop control at compact widths. Preserve the actual transcript text and timestamped segments, not merely a segment-count status. Verify session-relative offsets and explicit transcript export/retention.

Review local HTTP endpoint scheme, loopback host, redirects, timeouts, response limits, error redaction, and browser permissions. Check companion Origin/Host enforcement and pairing/authentication before using it outside a controlled dev setup; CORS alone is not a server authorization policy. Bound request sizes, model concurrency, and raw-audio memory. Add companion tests and document a reproducible dependency/toolchain setup.

Verify temporary-file cleanup on success, failure, cancellation, and shutdown, including multipart spooling. An OS/process crash can bypass `finally`. Zeroing one application buffer is not proof that browser/HTTP/runtime copies, swap, or storage have been securely erased. State the actual guarantees and limitations precisely. No cloud transcription fallback is permitted.

The prototype emits five-second MediaRecorder events but accumulates an entire recording until Stop. This is not bounded streaming transcription. Implement/test the approved bounded local-transcription plan before production-length lecture claims. Do not assume each MediaRecorder blob is an independently decodable audio file.

## Evidence format

For each gate item record: status (`not-run`, `running`, `passed`, `failed`, or `blocked`), repository/PR, head SHA, integration/base SHA when relevant, environment and tool versions, command or manual procedure, observed result, evidence/run link, remaining limitation, and who performed the check. Never make a green checkbox from the mere existence of a test.

## Human-only or access blockers

If the remaining work requires an actual instructor stylus/microphone/device, a missing approval, or unavailable permissions, stop that transition and notify the user once with the exact requirement. Do not repeatedly send the same blocker. Continue independent authorized fixes only; do not mark the gate passed or ask for another general implementation prompt.

## Reporting

Notify on a material fix, new actionable blocker, gate transition, or merge. Include exact PR/commit/run references and distinguish `implemented`, `validated`, and `merged`. Routine unchanged hourly checks should be silent.
