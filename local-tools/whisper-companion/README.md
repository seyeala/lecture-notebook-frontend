# Local Whisper Companion

This process is the local-only speech-to-text boundary for the lecture notebook.

It binds to `127.0.0.1` by default and uses OpenAI's open-source Whisper package locally. Lecture audio is written only to a temporary OS file because Whisper/FFmpeg needs a local media input path; that file is deleted in a `finally` block after transcription succeeds or fails.

## Install

Use a dedicated Python environment. Install FFmpeg separately for the host OS, then:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

On Windows PowerShell, activate with `.venv\Scripts\Activate.ps1`.

## Run

```bash
python app.py
```

Default endpoint:

```text
http://127.0.0.1:8178/v1/audio/transcriptions
```

Health:

```text
http://127.0.0.1:8178/health
```

## Model selection

The default is `small`. Override locally:

```bash
LECTURE_WHISPER_MODEL=medium python app.py
```

Whisper model weights are cached locally by Whisper. Those model files are not lecture data.

## CORS

The browser must be explicitly allowed. Development defaults allow only localhost/127.0.0.1 on port 8080. Set exact origins when needed:

```bash
LECTURE_NOTEBOOK_ORIGINS=https://notes.example.edu python app.py
```

Do not use a wildcard origin.

## Data retention

The companion does not create an audio library, database, object-store object, or cloud copy. Temporary audio is deleted after each request. The frontend additionally zeroes its in-memory audio byte buffer after the transcription request completes.

For long lectures, a later revision should transcribe bounded overlapping chunks rather than waiting for a single full-session recording.
