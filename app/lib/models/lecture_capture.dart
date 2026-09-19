import 'dart:convert';
import 'dart:typed_data';

class LecturePageManifest {
  const LecturePageManifest({
    required this.pageId,
    required this.pageIndex,
    required this.activeFrom,
    this.activeTo,
  });

  final String pageId;
  final int pageIndex;
  final DateTime activeFrom;
  final DateTime? activeTo;

  Map<String, Object?> toJson() => {
    'pageId': pageId,
    'pageIndex': pageIndex,
    'activeFrom': activeFrom.toUtc().toIso8601String(),
    'activeTo': activeTo?.toUtc().toIso8601String(),
  };
}

class LectureSessionManifest {
  const LectureSessionManifest({
    required this.schemaVersion,
    required this.sessionId,
    required this.createdAt,
    required this.capturedAt,
    required this.documentName,
    required this.currentPageId,
    required this.pages,
  });

  final int schemaVersion;
  final String sessionId;
  final DateTime createdAt;
  final DateTime capturedAt;
  final String documentName;
  final String currentPageId;
  final List<LecturePageManifest> pages;

  Map<String, Object?> toJson() => {
    'schemaVersion': schemaVersion,
    'sessionId': sessionId,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'capturedAt': capturedAt.toUtc().toIso8601String(),
    'documentName': documentName,
    'currentPageId': currentPageId,
    'pages': pages.map((page) => page.toJson()).toList(),
  };

  String toPrettyJson() => const JsonEncoder.withIndent('  ').convert(toJson());
}

class LectureCaptureBundle {
  const LectureCaptureBundle({
    required this.manifest,
    required this.notebookBytes,
  });

  final LectureSessionManifest manifest;
  final Uint8List notebookBytes;
}
