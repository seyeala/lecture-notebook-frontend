import 'package:butterfly/services/audio_capture.dart';
import 'package:butterfly/services/audio_capture_stub.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unsupported audio capture fails with a non-null explanation', () async {
    final service = createPlatformAudioCaptureService();

    expect(service.state, AudioCaptureState.idle);
    await expectLater(service.start(), throwsA(isA<UnsupportedError>()));
    expect(service.state, AudioCaptureState.error);
    expect(service.errorMessage, isNotEmpty);
    expect(service.startedAt, isNull);
    expect(await service.stop(), isNull);
    await service.dispose();
  });
}
