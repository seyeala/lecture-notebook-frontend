import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:butterfly/models/audio_capture.dart';
import 'package:butterfly/services/audio_capture.dart';
import 'package:web/web.dart';

AudioCaptureService createPlatformAudioCaptureService() =>
    WebAudioCaptureService();

class WebAudioCaptureService implements AudioCaptureService {
  AudioCaptureState _state = AudioCaptureState.idle;
  String? _errorMessage;
  DateTime? _startedAt;
  MediaStream? _stream;
  MediaRecorder? _recorder;
  final List<Blob> _chunks = [];

  @override
  AudioCaptureState get state => _state;

  @override
  String? get errorMessage => _errorMessage;

  @override
  DateTime? get startedAt => _startedAt;

  @override
  Future<void> start() async {
    if (_state == AudioCaptureState.recording) return;

    _state = AudioCaptureState.requestingPermission;
    _errorMessage = null;
    _chunks.clear();

    try {
      final constraints = MediaStreamConstraints(audio: true.toJS);
      final stream = await window.navigator.mediaDevices
          .getUserMedia(constraints)
          .toDart;
      final mimeType = _preferredMimeType();
      final recorder = mimeType == null
          ? MediaRecorder(stream)
          : MediaRecorder(stream, MediaRecorderOptions(mimeType: mimeType));

      recorder.ondataavailable = ((Event event) {
        final blob = (event as BlobEvent).data;
        if (blob.size > 0) _chunks.add(blob);
      }).toJS;

      _stream = stream;
      _recorder = recorder;
      _startedAt = DateTime.now().toUtc();
      _state = AudioCaptureState.recording;

      // Emit bounded browser chunks instead of one monolithic Blob.
      recorder.start(5000);
    } catch (error) {
      _state = AudioCaptureState.error;
      _errorMessage = error.toString();
      await _releaseStream();
      rethrow;
    }
  }

  @override
  Future<AudioCaptureArtifact?> stop() async {
    final recorder = _recorder;
    final startedAt = _startedAt;
    if (recorder == null ||
        startedAt == null ||
        _state != AudioCaptureState.recording) {
      return null;
    }

    final stopped = Completer<void>();
    recorder.onstop = ((Event event) {
      if (!stopped.isCompleted) stopped.complete();
    }).toJS;

    recorder.stop();
    await stopped.future;

    final endedAt = DateTime.now().toUtc();
    final mimeType = recorder.mimeType.isEmpty
        ? 'audio/webm'
        : recorder.mimeType;
    final blob = Blob(
      <BlobPart>[..._chunks].toJS,
      BlobPropertyBag(type: mimeType),
    );
    final buffer = await blob.arrayBuffer().toDart;
    final bytes = Uint8List.view(buffer.toDart);

    await _releaseStream();
    _recorder = null;
    _chunks.clear();
    _state = AudioCaptureState.stopped;

    return AudioCaptureArtifact(
      bytes: Uint8List.fromList(bytes),
      mimeType: mimeType,
      startedAt: startedAt,
      endedAt: endedAt,
    );
  }

  @override
  Future<void> dispose() async {
    final recorder = _recorder;
    if (recorder != null && recorder.state != 'inactive') {
      recorder.stop();
    }
    _recorder = null;
    _chunks.clear();
    await _releaseStream();
    _state = AudioCaptureState.idle;
  }

  String? _preferredMimeType() {
    const candidates = [
      'audio/webm;codecs=opus',
      'audio/webm',
      'audio/ogg;codecs=opus',
    ];
    for (final candidate in candidates) {
      if (MediaRecorder.isTypeSupported(candidate)) return candidate;
    }
    return null;
  }

  Future<void> _releaseStream() async {
    final stream = _stream;
    if (stream != null) {
      for (final track in stream.getTracks().toDart) {
        track.stop();
      }
    }
    _stream = null;
  }
}
