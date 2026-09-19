import 'package:butterfly/models/audio_capture.dart';
import 'package:butterfly/services/audio_capture.dart';

AudioCaptureService createPlatformAudioCaptureService() =>
    UnsupportedAudioCaptureService();

class UnsupportedAudioCaptureService implements AudioCaptureService {
  @override
  AudioCaptureState state = AudioCaptureState.idle;

  @override
  String? errorMessage;

  @override
  DateTime? startedAt;

  @override
  Future<void> start() async {
    state = AudioCaptureState.error;
    errorMessage = 'Audio capture is not supported on this platform yet.';
    throw UnsupportedError(errorMessage);
  }

  @override
  Future<AudioCaptureArtifact?> stop() async => null;

  @override
  Future<void> dispose() async {}
}
