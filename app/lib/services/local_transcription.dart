import 'package:butterfly/models/audio_capture.dart';
import 'package:butterfly/models/local_transcript.dart';

abstract class LocalTranscriptionService {
  Future<LocalTranscript> transcribe(AudioCaptureArtifact audio);
  void dispose();
}
