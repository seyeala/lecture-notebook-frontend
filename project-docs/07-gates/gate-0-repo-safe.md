# Gate 0: Repo Safe

## Purpose

Confirm the repository is safe enough to begin CP-1 build baseline work.

## Required checks

```text
[ ] README clearly identifies this fork as Live Lecture-to-LaTeX Notebook frontend.
[ ] Upstream Butterfly attribution is retained.
[ ] AGPL/source-availability obligation is documented.
[ ] project-docs/ exists and contains checkpoint/gate material.
[ ] deploy.yml cannot deploy automatically.
[ ] release.yml cannot tag, release, version-bump, or notify automatically.
[ ] No application code changed in CP-0.
[ ] develop branch protection is enabled or explicitly deferred by owner.
[ ] Issues/project tracking is enabled or explicitly deferred by owner.
```

## Hard fail conditions

Gate 0 fails if any of these are true:

```text
An inherited workflow can still deploy on push.
An inherited workflow can still create releases or move tags.
Product implementation starts before baseline documentation exists.
Backend secrets or model/provider details are committed to the frontend repository.
The fork removes upstream license notices without legal review.
```

## Manual settings checklist

Repository owner should review:

```text
Settings → Branches → protect develop.
Settings → General → pull request merge policy.
Settings → General → Issues enabled if using GitHub Issues.
Settings → Secrets and variables → confirm no inherited/upstream deployment secrets are present.
```

## Gate decision record

Record the Gate 0 decision in the CP-0 pull request before merging.
