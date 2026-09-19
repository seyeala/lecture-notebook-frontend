# Local Whisper Companion Runbook

The lecture notebook web client sends temporary audio only to a loopback service on the instructor's own machine.

## Start

From `local-tools/whisper-companion`:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

Windows PowerShell:

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python app.py
```

FFmpeg must also be installed on the host because OpenAI Whisper uses it to decode media.

## Endpoints

```text
GET  http://127.0.0.1:8178/health
POST http://127.0.0.1:8178/v1/audio/transcriptions
```

The transcription endpoint accepts OpenAI-style multipart fields `file`, `model`, and `response_format=verbose_json`.

## Local Network Access

Modern browsers can ask the user for permission when a public/HTTPS web application accesses a loopback service. Treat this permission as part of the local-companion onboarding flow. The browser app must never fall back to a remote transcription service when loopback access is denied.

The frontend adapter rejects non-loopback hosts by construction.

## Data lifecycle

1. Browser records compressed audio locally.
2. Browser POSTs the bytes to `127.0.0.1`.
3. Companion writes a temporary OS file for Whisper/FFmpeg.
4. Whisper returns text and timestamped segments.
5. Companion deletes the temporary file in `finally`.
6. Frontend zeroes the in-memory audio buffer after the request resolves or fails.
7. Transcript/timing metadata may be retained as lecture-session data.

No raw lecture audio is intentionally retained.

## Failure behavior

If transcription fails, the current privacy-first implementation discards the in-memory audio rather than silently retaining it. The UI surfaces the failure and the instructor may record again.

## Long lectures

The current adapter proves the local lifecycle. Before production-length lectures, implement bounded overlapping chunks so the browser does not accumulate an entire lecture recording in memory. Chunk transcription must preserve a cumulative time offset and small overlap to reduce sentence-boundary loss.
