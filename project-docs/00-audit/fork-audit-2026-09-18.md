# Fork Audit — 2026-09-18

Repository audited:

```text
seyeala/lecture-notebook-frontend
```

## Result

The repository is a clean fork of `LinwoodDev/Butterfly` and is a suitable starting point for the Live Lecture-to-LaTeX Notebook frontend.

## Findings

```text
Default branch: develop
Frontend base: LinwoodDev/Butterfly
Primary language: Dart / Flutter
License: AGPL-3.0
Project visibility at audit time: public
Custom application code at audit time: none
```

The fork started from the correct upstream source. No alternate community fork should be used as the base. The upstream repository is the maintained source of truth for the notebook application, and this fork should track upstream intentionally rather than drifting accidentally.

## Risks found

1. Upstream deploy and release workflows were still present.
2. The README still described upstream Butterfly rather than this project.
3. Project-control documentation did not yet exist.
4. Branch protection and issue/discussion settings still require repository-owner confirmation.
5. The app package identity is still upstream Butterfly. This is acceptable for CP-0, but must be revisited before external alpha.

## CP-0 remediation

CP-0 addresses the documentation and workflow-safety items only. It does not modify application behavior.

```text
README revised: yes
Project docs added: yes
Deploy workflow disabled: yes
Release workflow disabled: yes
Application code changed: no
```

## Manual owner checks still required

These require repository settings access and should be confirmed manually before Gate 0 is marked complete:

```text
Protect develop.
Require pull requests before merge.
Require at least one approval.
Disable force-pushes to develop.
Enable delete branch on merge.
Prefer squash merge.
Enable Issues if project tracking will use GitHub Issues.
```
