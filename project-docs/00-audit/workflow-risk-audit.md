# Workflow Risk Audit

## Scope

This audit covers the upstream GitHub Actions workflows that were inherited from Butterfly and are not yet appropriate for this fork.

## High-risk workflows

```text
.github/workflows/deploy.yml
.github/workflows/release.yml
```

## Deploy workflow risk

The inherited deploy workflow had push triggers for `develop` and `main` and attempted to deploy built documentation and web artifacts using SFTP secrets and upstream Butterfly deployment paths.

This is unsafe for the fork because:

```text
It was designed for Butterfly infrastructure, not Lecture Notebook infrastructure.
It referenced upstream deployment locations.
It assumed secrets that should not exist in this fork.
It could run on branch pushes before the project has a release process.
```

## Release workflow risk

The inherited release workflow contained upstream release automation, tag movement, changelog generation, CI identity configuration, stable/nightly tag logic, and Discord webhook messaging.

This is unsafe for the fork because:

```text
It could create misleading release tags.
It refers to Butterfly versioning and release semantics.
It uses upstream-oriented CI identity and URLs.
It is not connected to a reviewed Lecture Notebook release process.
```

## CP-0 control

Both workflows are replaced with manually triggered disabled stubs. They intentionally perform no deployment, tagging, release creation, version bumping, or external notification.

## Re-enable criteria

Do not re-enable deploy or release automation until all are true:

```text
A Lecture Notebook preview environment exists.
Deployment targets are documented.
Secrets are provisioned for this fork only.
Release branches and versioning rules are documented.
AGPL source availability requirements are satisfied.
Rollback procedure exists.
Gate 5 external-user readiness has passed.
```
