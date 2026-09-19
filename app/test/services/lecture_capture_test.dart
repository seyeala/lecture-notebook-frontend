import 'package:butterfly/services/lecture_capture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('session id remains stable for the service lifetime', () {
    var now = DateTime.utc(2026, 9, 18, 18);
    final service = LectureCaptureService(clock: () => now);

    final first = service.sessionId;
    now = now.add(const Duration(minutes: 30));
    final second = service.sessionId;

    expect(first, second);
    expect(first, 'lecture-1789754400000000');
  });

  test('page observation does not rotate the session id', () {
    var now = DateTime.utc(2026, 9, 18, 18);
    final service = LectureCaptureService(clock: () => now);

    service.observePage('page-1');
    final sessionId = service.sessionId;
    now = now.add(const Duration(minutes: 10));
    service.observePage('page-2');

    expect(service.sessionId, sessionId);
  });
}
