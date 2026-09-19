import 'package:butterfly/models/audio_capture.dart';

enum AudioCaptureState { idle, requestingPermission, recording, stopped, error }

abstract class AudioCaptureService {
  AudioCaptureState get state;
  String? get errorMessage;
  DateTime? get startedAt;

  Future<void> start();
  Future<AudioCaptureArtifact?> stop();
  Future<void> dispose();
}
