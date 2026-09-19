class TranscriptSegment {
  const TranscriptSegment({
    required this.text,
    required this.start,
    required this.end,
  });

  final String text;
  final Duration start;
  final Duration end;
}

class LocalTranscript {
  const LocalTranscript({
    required this.text,
    required this.segments,
    required this.modelId,
    required this.completedAt,
    this.language,
  });

  final String text;
  final List<TranscriptSegment> segments;
  final String modelId;
  final DateTime completedAt;
  final String? language;
}
