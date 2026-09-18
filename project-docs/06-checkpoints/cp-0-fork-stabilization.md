# CP-0: Fork Stabilization

## Purpose

Make the fork safe to modify before any application code changes.

## Scope

In scope:

```text
README revision.
Project-control docs.
Workflow safety.
Branch strategy documentation.
AGPL/source-boundary notes.
Initial ADRs.
```

Out of scope:

```text
Split-pane UI.
Audio capture.
Backend integration.
App renaming.
Flutter dependency changes.
Release deployment.
```

## Deliverables

```text
project-docs/README.md
project-docs/00-audit/fork-audit-2026-09-18.md
project-docs/00-audit/workflow-risk-audit.md
project-docs/00-audit/upstream-sync-policy.md
project-docs/01-product/project-brief.md
project-docs/02-architecture/backend-boundary.md
project-docs/04-compliance/agpl-compliance-plan.md
project-docs/06-checkpoints/checkpoint-plan.md
project-docs/07-gates/gate-plan.md
project-docs/07-gates/gate-0-repo-safe.md
project-docs/08-decisions/ADR-0001-use-butterfly.md
project-docs/08-decisions/ADR-0002-web-first.md
project-docs/08-decisions/ADR-0003-keep-backend-separate.md
project-docs/08-decisions/ADR-0004-disable-upstream-release-pipeline.md
project-docs/08-decisions/ADR-0005-project-docs-location.md
```

## File changes

```text
README.md
.github/workflows/deploy.yml
.github/workflows/release.yml
```

## Pass criteria

CP-0 is complete when Gate 0 passes.

## Owner/manual actions

Some repository settings may need to be changed manually in GitHub:

```text
Protect develop.
Require pull requests.
Enable issues if needed.
Set preferred merge policy.
Confirm no deploy/release secrets are attached to this fork unless intentionally provisioned.
```
