import 'dart:typed_data';

class AudioCaptureArtifact {
  const AudioCaptureArtifact({
    required this.bytes,
    required this.mimeType,
    required this.startedAt,
    required this.endedAt,
  });

  final Uint8List bytes;
  final String mimeType;
  final DateTime startedAt;
  final DateTime endedAt;

  Duration get duration => endedAt.difference(startedAt);

  void discard() {
    bytes.fillRange(0, bytes.length, 0);
  }
}
