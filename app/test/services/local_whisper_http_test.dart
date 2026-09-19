import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/models/audio_capture.dart';
import 'package:butterfly/services/local_whisper_http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('rejects non-loopback transcription endpoints', () {
    expect(
      () => LocalWhisperHttpTranscriptionService(
        endpoint: Uri.parse('https://example.com/v1/audio/transcriptions'),
      ),
      throwsArgumentError,
    );
  });

  test('parses verbose local Whisper transcript with timestamps', () async {
    final client = MockClient((request) async {
      expect(request.url.host, '127.0.0.1');
      expect(request.followRedirects, isFalse);
      return http.Response(
        jsonEncode({
          'text': 'First segment. Second segment.',
          'language': 'en',
          'model': 'openai-whisper/small',
          'segments': [
            {'start': 0.0, 'end': 1.25, 'text': ' First segment. '},
            {'start': 1.25, 'end': 2.5, 'text': ' Second segment. '},
          ],
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    final service = LocalWhisperHttpTranscriptionService(client: client);
    final audio = AudioCaptureArtifact(
      bytes: Uint8List.fromList([1, 2, 3]),
      mimeType: 'audio/webm',
      startedAt: DateTime.utc(2026),
      endedAt: DateTime.utc(2026, 1, 1, 0, 0, 3),
    );

    final transcript = await service.transcribe(audio);

    expect(transcript.text, 'First segment. Second segment.');
    expect(transcript.language, 'en');
    expect(transcript.modelId, 'openai-whisper/small');
    expect(transcript.segments, hasLength(2));
    expect(transcript.segments.first.start, Duration.zero);
    expect(
      transcript.segments.first.end,
      const Duration(milliseconds: 1250),
    );
    service.dispose();
  });
}
