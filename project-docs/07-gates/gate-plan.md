# Gate Plan

## Gate rule

A gate is a hard stop. The next checkpoint should not begin until the current gate has passed or an explicit exception is documented.

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

Required before backend integration.

Pass criteria:

```text
Split-pane shell works.
Existing notebook drawing remains usable.
Right PDF placeholder renders.
Toolbar layout is accepted.
Tablet/laptop widths are checked.
```

## Gate 3: Data Export Accepted

Required before model/backend work.

Pass criteria:

```text
Notebook/page export path works.
Audio recording path works.
Session metadata exists.
Fake upload succeeds.
No backend secrets appear in frontend.
```

## Gate 4: Backend Boundary Accepted

Required before AI/model integration.

Pass criteria:

```text
Frontend uses API calls only.
Prompt/model routing stays backend-side.
Job status contract works.
Generated PDF display works from backend URL.
Failure states are visible.
```

## Gate 5: External User Readiness

Required before external users.

Pass criteria:

```text
Source Code link exists in deployed frontend.
AGPL source availability path works.
Audio/privacy notice exists.
Data retention policy is drafted.
Known failure modes are documented.
Legal review is complete or explicitly scheduled before launch.
```
