import 'dart:typed_data';

import 'package:butterfly/models/audio_capture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('discard zeroes captured audio bytes', () {
    final artifact = AudioCaptureArtifact(
      bytes: Uint8List.fromList([1, 2, 3, 4]),
      mimeType: 'audio/webm',
      startedAt: DateTime.utc(2026, 9, 18, 18),
      endedAt: DateTime.utc(2026, 9, 18, 18, 1),
    );

    artifact.discard();

    expect(artifact.bytes, [0, 0, 0, 0]);
  });

  test('duration is derived from capture timestamps', () {
    final artifact = AudioCaptureArtifact(
      bytes: Uint8List(0),
      mimeType: 'audio/webm',
      startedAt: DateTime.utc(2026, 9, 18, 18),
      endedAt: DateTime.utc(2026, 9, 18, 18, 2, 30),
    );

    expect(artifact.duration, const Duration(minutes: 2, seconds: 30));
  });
}
