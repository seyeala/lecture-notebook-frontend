# Live Lecture-to-LaTeX Notebook Frontend

This repository is the instructor-facing frontend for the **Live Lecture-to-LaTeX Notebook** project.

It is a fork of [Linwood Butterfly](https://github.com/LinwoodDev/Butterfly), used as the notebook/canvas base for a web-first lecture capture application. The project goal is to let an instructor write lecture notes with a stylus, record lecture audio, send notebook/audio/context artifacts to a separate backend, and view a generated student-facing LaTeX/PDF note in the same interface.

Current project status:

```text
Phase: CP-0 fork stabilization
Target: web-first MVP
Frontend base: LinwoodDev/Butterfly
License: AGPL-3.0 for the modified frontend
Backend boundary: separate proprietary services over HTTP/WebSocket/SSE
Application code changes in this fork: not started in CP-0
```

Project-control documentation lives in [`project-docs/`](project-docs/README.md).

## Development policy for this fork

Do not commit product changes directly to `develop`. Use project branches and pull requests.

Initial branch model:

```text
develop
  Tracks the Butterfly-based integration base.

project/bootstrap-controls
  CP-0 branch for repository controls, documentation, and workflow safety.

feature/*
  Future implementation branches.

release/mvp-alpha
  Future controlled release branch.
```

## AGPL and source availability

This modified frontend remains under AGPL-3.0 unless legal review and upstream licensing allow a different path. If a modified version is deployed for users over a network, the project must provide those users access to the corresponding frontend source code.

The proprietary backend should remain separate from the AGPL frontend boundary. Keep secrets, model routing, prompts, billing logic, storage policy, analytics, and AI orchestration out of this frontend repository.

## Upstream Butterfly attribution

This fork is based on Linwood Butterfly.

Upstream repository: <https://github.com/LinwoodDev/Butterfly>  
Upstream website: <https://butterfly.linwood.dev>  
Upstream license: [AGPL-3.0](./LICENSE)

Butterfly is an open-source, cross-platform note-taking app. The upstream app supports handwriting, text and Markdown, shapes, images, PDFs, SVGs, pages, folders, layers, templates, palettes, stamps, grids, rulers, export workflows, local-first storage, WebDAV/Nextcloud storage, web builds, desktop builds, and mobile/tablet targets.

The upstream README describes Butterfly as follows:

> Butterfly is an open-source app for people who think better with space around their ideas. Instead of writing everything from top to bottom on a fixed page, you get an endless workspace where you can place notes, sketches, diagrams, images, and documents wherever they make sense.

## Upstream license notices retained

The code is open source and licensed under the [AGPL-3.0](./LICENSE) license.

All images in `app/images/` and content in `docs/` are licensed under the [CC-BY-SA-4.0](./BRANDING_LICENSE) license.

The files in `api` are licensed under the [Apache-2.0](./api/LICENSE) license instead of the AGPL-3.0 license to allow use of the API without the need to open source separate code, for example extensions or other external services.

## Product direction

The frontend will eventually add:

```text
left pane:  Butterfly notebook canvas
right pane: generated PDF viewer
toolbar:    record, stop, generate, prompt/profile selector, job status
outputs:    generated PDF, LaTeX, transcript, compile logs, version history
```

The first implementation checkpoint after CP-0 is CP-1: build baseline. No split-pane UI work should begin until the fork builds cleanly from a fresh clone and the baseline process is documented.
