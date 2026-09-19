import os
import tempfile
from pathlib import Path

import whisper
from fastapi import FastAPI, File, Form, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

HOST = "127.0.0.1"
PORT = int(os.environ.get("LECTURE_WHISPER_PORT", "8178"))
MODEL_NAME = os.environ.get("LECTURE_WHISPER_MODEL", "small")
ORIGINS = [
    value.strip()
    for value in os.environ.get(
        "LECTURE_NOTEBOOK_ORIGINS",
        "http://localhost:8080,http://127.0.0.1:8080",
    ).split(",")
    if value.strip()
]

app = FastAPI(title="Lecture Notebook Local Whisper Companion")
app.add_middleware(
    CORSMiddleware,
    allow_origins=ORIGINS,
    allow_credentials=False,
    allow_methods=["POST", "GET"],
    allow_headers=["*"],
)

_model = None


def get_model():
    global _model
    if _model is None:
        _model = whisper.load_model(MODEL_NAME)
    return _model


@app.get("/health")
def health():
    return {
        "status": "ok",
        "engine": "openai-whisper",
        "model": MODEL_NAME,
        "storage": "ephemeral",
    }


@app.post("/v1/audio/transcriptions")
async def transcribe(
    file: UploadFile = File(...),
    model: str = Form("whisper-1"),
    response_format: str = Form("verbose_json"),
):
    del model
    if response_format != "verbose_json":
        return JSONResponse(
            status_code=400,
            content={"error": "Only verbose_json is supported."},
        )

    suffix = Path(file.filename or "lecture.webm").suffix or ".webm"
    temp_path = None
    try:
        with tempfile.NamedTemporaryFile(
            prefix="lecture-whisper-",
            suffix=suffix,
            delete=False,
        ) as temp_file:
            temp_path = temp_file.name
            while chunk := await file.read(1024 * 1024):
                temp_file.write(chunk)

        result = get_model().transcribe(
            temp_path,
            verbose=False,
            word_timestamps=False,
        )
        segments = [
            {
                "id": segment.get("id"),
                "start": segment.get("start"),
                "end": segment.get("end"),
                "text": segment.get("text", "").strip(),
            }
            for segment in result.get("segments", [])
        ]
        return {
            "text": result.get("text", "").strip(),
            "segments": segments,
            "language": result.get("language"),
            "model": f"openai-whisper/{MODEL_NAME}",
        }
    finally:
        await file.close()
        if temp_path:
            try:
                os.remove(temp_path)
            except FileNotFoundError:
                pass


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host=HOST, port=PORT)
