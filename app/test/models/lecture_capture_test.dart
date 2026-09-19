import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/models/lecture_capture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lecture session manifest serializes stable capture fields', () {
    final manifest = LectureSessionManifest(
      schemaVersion: 1,
      sessionId: 'lecture-123',
      createdAt: DateTime.utc(2026, 9, 18, 18),
      capturedAt: DateTime.utc(2026, 9, 18, 18, 30),
      documentName: 'ME 228 Lecture 07',
      currentPageId: 'page-2',
      pages: [
        LecturePageManifest(
          pageId: 'page-1',
          pageIndex: 0,
          activeFrom: DateTime.utc(2026, 9, 18, 18),
          activeTo: DateTime.utc(2026, 9, 18, 18, 15),
        ),
        LecturePageManifest(
          pageId: 'page-2',
          pageIndex: 1,
          activeFrom: DateTime.utc(2026, 9, 18, 18, 15),
        ),
      ],
    );

    final json = manifest.toJson();

    expect(json['schemaVersion'], 1);
    expect(json['sessionId'], 'lecture-123');
    expect(json['currentPageId'], 'page-2');
    expect((json['pages'] as List<Object?>).length, 2);
    expect(
      jsonDecode(manifest.toPrettyJson())['documentName'],
      'ME 228 Lecture 07',
    );
  });

  test('capture bundle retains notebook bytes', () {
    final manifest = LectureSessionManifest(
      schemaVersion: 1,
      sessionId: 'lecture-123',
      createdAt: DateTime.utc(2026),
      capturedAt: DateTime.utc(2026, 1, 1, 0, 1),
      documentName: 'Lecture',
      currentPageId: 'page-1',
      pages: [
        LecturePageManifest(
          pageId: 'page-1',
          pageIndex: 0,
          activeFrom: DateTime.utc(2026),
        ),
      ],
    );
    final bundle = LectureCaptureBundle(
      manifest: manifest,
      notebookBytes: Uint8List.fromList([1, 2, 3]),
    );

    expect(bundle.notebookBytes, isNotEmpty);
    expect(bundle.notebookBytes, Uint8List.fromList([1, 2, 3]));
  });
}
