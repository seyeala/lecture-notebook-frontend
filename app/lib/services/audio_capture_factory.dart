import 'audio_capture.dart';
import 'audio_capture_stub.dart'
    if (dart.library.js_interop) 'audio_capture_web.dart';

AudioCaptureService createAudioCaptureService() =>
    createPlatformAudioCaptureService();
