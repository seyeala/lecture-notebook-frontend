import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/lecture_capture.dart';

class LectureCaptureService {
  LectureCaptureService({DateTime Function()? clock}) {
    _clock = clock ?? DateTime.now;
  }

  late final DateTime Function() _clock;
  String? _sessionId;
  DateTime? _createdAt;
  String? _activePageId;
  final Map<String, DateTime> _pageFirstSeen = {};
  final Map<String, DateTime?> _pageLastLeft = {};

  String get sessionId => _sessionId ??= _createSessionId();

  void observePage(String pageId) {
    final now = _clock();
    _createdAt ??= now;
    _pageFirstSeen.putIfAbsent(pageId, () => now);

    if (_activePageId == pageId) return;
    final previousPage = _activePageId;
    if (previousPage != null) {
      _pageLastLeft[previousPage] = now;
    }
    _activePageId = pageId;
  }

  Future<LectureCaptureBundle?> capture(DocumentState state) async {
    if (state is! DocumentLoaded) return null;

    final now = _clock();
    observePage(state.pageName);
    final savedData = await state.saveData();
    final notebookBytes = savedData.exportAsBytes();
    final pageIds = savedData.getPages(true);
    final createdAt = _createdAt ?? now;

    final pages = <LecturePageManifest>[];
    for (var index = 0; index < pageIds.length; index++) {
      final pageId = pageIds[index];
      pages.add(
        LecturePageManifest(
          pageId: pageId,
          pageIndex: index,
          activeFrom: _pageFirstSeen[pageId] ?? createdAt,
          activeTo: pageId == _activePageId ? null : _pageLastLeft[pageId],
        ),
      );
    }

    return LectureCaptureBundle(
      manifest: LectureSessionManifest(
        schemaVersion: 1,
        sessionId: sessionId,
        createdAt: createdAt,
        capturedAt: now,
        documentName: state.metadata.name,
        currentPageId: state.pageName,
        pages: pages,
      ),
      notebookBytes: Uint8List.fromList(notebookBytes),
    );
  }

  String _createSessionId() {
    final now = _clock().toUtc();
    return 'lecture-${now.microsecondsSinceEpoch}';
  }
}
