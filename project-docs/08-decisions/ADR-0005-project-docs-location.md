# ADR-0005: Store Project-Control Docs in project-docs/

## Status

Accepted.

## Context

The upstream Butterfly repository already contains a `docs/` directory for the public Butterfly documentation site. Mixing internal project-control material into that directory would blur upstream docs, product docs, and project governance.

## Decision

Store Live Lecture-to-LaTeX Notebook project-control documentation in:

```text
project-docs/
```

Do not use the upstream `docs/` directory for checkpoint, gate, audit, compliance, or architecture-control documents unless a future documentation-site migration is deliberately approved.

## Consequences

Positive:

```text
Keeps upstream documentation site intact.
Separates project governance from product docs.
Reduces risk during upstream sync.
Makes CP/gate material easy to find.
```

Negative:

```text
There are now two documentation roots.
Developers must know that `docs/` is upstream/product-site material and `project-docs/` is project-control material.
```

## Follow-up

If the project later needs public user documentation for the lecture product, decide whether to extend the existing Astro docs site or create a separate documentation site.
