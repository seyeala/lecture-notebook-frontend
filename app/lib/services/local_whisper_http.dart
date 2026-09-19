import 'dart:convert';

import 'package:butterfly/models/audio_capture.dart';
import 'package:butterfly/models/local_transcript.dart';
import 'package:butterfly/services/local_transcription.dart';
import 'package:http/http.dart' as http;

class LocalWhisperHttpTranscriptionService
    implements LocalTranscriptionService {
  LocalWhisperHttpTranscriptionService({
    Uri? endpoint,
    http.Client? client,
    this.modelId = 'whisper-1',
  }) : endpoint =
           endpoint ??
           Uri.parse('http://127.0.0.1:8178/v1/audio/transcriptions'),
       _client = client ?? http.Client() {
    if (!_isLoopback(endpoint ?? this.endpoint)) {
      throw ArgumentError(
        'Local Whisper endpoint must resolve to localhost/loopback.',
      );
    }
  }

  final Uri endpoint;
  final String modelId;
  final http.Client _client;

  @override
  Future<LocalTranscript> transcribe(AudioCaptureArtifact audio) async {
    final request = http.MultipartRequest('POST', endpoint)
      // Raw lecture audio must never follow a server redirect to another host.
      // A redirect is treated as a transcription failure instead.
      ..followRedirects = false
      ..fields['model'] = modelId
      ..fields['response_format'] = 'verbose_json'
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          audio.bytes,
          filename: _fileNameFor(audio.mimeType),
        ),
      );

    final streamed = await _client.send(request);
    final response = await http.Response.fromStream(streamed);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw LocalTranscriptionException(
        'Local Whisper returned HTTP ${response.statusCode}: '
        '${response.body}',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const LocalTranscriptionException(
        'Local Whisper returned an invalid JSON object.',
      );
    }

    final rawSegments = decoded['segments'];
    final segments = <TranscriptSegment>[];
    if (rawSegments is List) {
      for (final raw in rawSegments) {
        if (raw is! Map) continue;
        final start = (raw['start'] as num?)?.toDouble();
        final end = (raw['end'] as num?)?.toDouble();
        final text = raw['text']?.toString().trim() ?? '';
        if (start == null || end == null || text.isEmpty) continue;
        segments.add(
          TranscriptSegment(
            text: text,
            start: Duration(milliseconds: (start * 1000).round()),
            end: Duration(milliseconds: (end * 1000).round()),
          ),
        );
      }
    }

    final text = decoded['text']?.toString().trim() ?? '';
    return LocalTranscript(
      text: text,
      segments: segments,
      modelId: decoded['model']?.toString() ?? modelId,
      completedAt: DateTime.now().toUtc(),
      language: decoded['language']?.toString(),
    );
  }

  @override
  void dispose() => _client.close();

  static bool _isLoopback(Uri uri) {
    final host = uri.host.toLowerCase();
    return host == '127.0.0.1' || host == 'localhost' || host == '::1';
  }

  static String _fileNameFor(String mimeType) {
    if (mimeType.contains('ogg')) return 'lecture.ogg';
    if (mimeType.contains('wav')) return 'lecture.wav';
    return 'lecture.webm';
  }
}

class LocalTranscriptionException implements Exception {
  const LocalTranscriptionException(this.message);

  final String message;

  @override
  String toString() => 'LocalTranscriptionException: $message';
}
