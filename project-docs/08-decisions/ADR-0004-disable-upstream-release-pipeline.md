# ADR-0004: Disable Upstream Deploy and Release Pipelines

## Status

Accepted.

## Context

The fork inherited Butterfly workflows for deployment and release management. These workflows were built for upstream Butterfly infrastructure and release semantics.

The inherited deploy workflow could deploy documentation and web artifacts through SFTP. The inherited release workflow could generate changelogs, create or move tags, create releases, bump versions, merge branches, and send Discord notifications.

## Decision

Replace the inherited deploy and release workflows with disabled manual stubs during CP-0.

## Consequences

Positive:

```text
No accidental deployment from this fork.
No accidental tag movement or release creation.
No upstream-branded Discord/release messaging.
No reliance on unknown inherited secrets.
```

Negative:

```text
No automated preview deploy exists yet.
No project release workflow exists yet.
A future release pipeline must be designed deliberately.
```

## Re-enable conditions

Deployment/release automation can be reintroduced only after:

```text
Preview target is defined.
Production target is defined.
Secrets are provisioned specifically for this fork.
Release versioning is documented.
Rollback path is documented.
AGPL source availability path is implemented.
Gate 5 is satisfied for external users.
```
