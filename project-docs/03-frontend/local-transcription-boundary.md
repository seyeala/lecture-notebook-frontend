# Local Transcription Boundary

## Requirement

Lecture audio must remain on the instructor's device and should be deleted after local transcription succeeds.

## Reference engine

Use OpenAI Whisper as the reference model/implementation. The official project is open source under MIT and supports local transcription with multiple model sizes.

## Important web-app constraint

The current product target is a Flutter web app. The official Whisper reference implementation uses Python/PyTorch and FFmpeg; it does not execute directly inside an ordinary browser tab. Therefore "local Whisper" requires one of these later implementation choices:

1. a small localhost companion process running Whisper on the instructor machine;
2. packaging the frontend as a desktop app with a local transcription sidecar;
3. a reviewed browser-native/WASM/WebGPU Whisper runtime.

CP-4 must not silently send audio to a cloud transcription endpoint as a shortcut.

## Preferred initial integration boundary

Define a local transcription interface independent of runtime:

```text
LocalTranscriptionService.transcribe(audio)
  -> LocalTranscript
```

A future localhost adapter can implement that contract without changing lecture-session semantics.

## Transcript contract

Durable transcript output should include:

- transcript text
- segment start/end timestamps
- detected/selected language
- model identifier
- transcription completion time
- optional uncertainty/warning metadata

Word timestamps are desirable when performance permits because Whisper supports timestamp generation, but segment timing is sufficient for the first lecture/page alignment pipeline.

## Cleanup contract

After successful transcription:

1. commit transcript/timing metadata locally;
2. release microphone/media resources;
3. delete temporary audio bytes/files;
4. expose cleanup failure as a privacy-relevant warning.
