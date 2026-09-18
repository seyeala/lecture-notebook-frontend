# Project Brief

## Product name

Live Lecture-to-LaTeX Notebook.

## Goal

Build a web-accessible notebook app where an instructor writes lecture notes with a stylus, records/transcribes lecture audio, sends notebook artifacts plus transcript plus course instructions to a separate AI backend, and receives a polished student-facing LaTeX/PDF lecture note in the same interface.

## Core user experience

```text
Left pane:
  Butterfly-based handwriting notebook.

Top controls:
  Record, stop, generate/update, prompt profile, job status.

Right pane:
  Generated PDF viewer.

Backend:
  Transcription, AI orchestration, LaTeX generation, compile/repair, storage, job status.
```

## MVP scope

The MVP proves a complete instructor workflow:

```text
Open lecture session.
Write notes with stylus.
Record lecture audio.
Click Generate Notes.
Upload notebook/page exports and audio.
Receive job status.
Display generated PDF.
Download PDF, LaTeX, transcript, and logs.
```

## Non-goals for MVP

```text
No real-time generation while writing.
No collaborative classrooms.
No LMS export.
No full student portal.
No custom handwriting engine from scratch.
No attempt to compete as a generic OCR app.
```

## Product principle

The differentiator is not handwriting OCR alone. The product value is the full pipeline:

```text
handwriting + lecture audio + course context + instructor prompt
→ pedagogically cleaned LaTeX
→ compiled student-ready PDF
→ visible immediately next to the original notebook
```

## Frontend principle

Use Butterfly for the notebook layer. Do not rewrite the canvas unless Butterfly proves unusable after a documented checkpoint failure.
