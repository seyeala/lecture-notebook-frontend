# Upstream Sync Policy

## Source of truth

The upstream source of truth for the notebook base is:

```text
LinwoodDev/Butterfly
```

This fork should not attempt to become an independent general-purpose Butterfly replacement. It should remain focused on the lecture-to-LaTeX product layer.

## Local branch roles

```text
develop
  Integration base for this fork. Keep it close to upstream unless a project decision says otherwise.

project/*
  Project-control, documentation, and milestone branches.

feature/*
  Product implementation branches.

release/*
  Controlled release stabilization branches.
```

## Sync rule

Before significant frontend work, compare this fork against upstream `LinwoodDev/Butterfly:develop` and record the result in the relevant PR.

Recommended command-line check:

```bash
git remote add upstream https://github.com/LinwoodDev/Butterfly.git
git fetch upstream
git log --oneline --left-right --cherry-pick origin/develop...upstream/develop
```

## Conflict policy

When upstream changes conflict with Lecture Notebook changes, prefer preserving upstream notebook behavior unless the project change is directly required for:

```text
split-pane lecture workflow;
audio capture;
generation job controls;
PDF result viewing;
AGPL source-code link;
backend API integration.
```

## Rebase/merge policy

For now, use small PRs and avoid large unreviewed merges from upstream. Record upstream sync points in PR descriptions.

## Gate dependency

Gate 1 cannot pass unless the build baseline documents the upstream commit or branch point used for the frontend build.
