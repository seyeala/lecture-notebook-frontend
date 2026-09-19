import 'dart:io';

import 'package:butterfly/views/lecture/generated_notes_panel.dart';
import 'package:butterfly/views/lecture/lecture_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';

const _notebookKey = Key('test-notebook');
const _splitBreakpoint = LeapBreakpoints.expanded + 320 + 1;

void main() {
  test('split-pane docs pin the implementation breakpoint', () {
    final plan = File('../project-docs/03-frontend/split-pane-ui-plan.md')
        .readAsStringSync();

    expect(
      plan,
      contains(
        '1200 logical pixels notebook + 1 pixel divider + '
        '320 pixel notes minimum',
      ),
    );
    expect(plan, contains('= 1521 logical pixels minimum split width'));
    expect(plan, contains('Below 1521 logical pixels'));
    expect(plan, isNot(contains('1000 logical pixels')));
  });

  testWidgets('keeps the notebook full width below the split breakpoint', (
    tester,
  ) async {
    _setViewport(tester, width: _splitBreakpoint - 1);
    addTearDown(() => _resetViewport(tester));

    await tester.pumpWidget(_buildShell(const SizedBox(key: _notebookKey)));

    expect(find.byType(GeneratedNotesPanel), findsNothing);
    expect(
      tester.getSize(find.byKey(_notebookKey)).width,
      _splitBreakpoint - 1,
    );
  });

  testWidgets('shows the notes pane exactly at the split breakpoint', (
    tester,
  ) async {
    _setViewport(tester, width: _splitBreakpoint);
    addTearDown(() => _resetViewport(tester));

    await tester.pumpWidget(_buildShell(const SizedBox(key: _notebookKey)));

    expect(find.byType(GeneratedNotesPanel), findsOneWidget);
    expect(tester.getSize(find.byKey(_notebookKey)).width, 1200);
    expect(tester.getSize(find.byType(GeneratedNotesPanel)).width, 320);
  });

  testWidgets('preserves notebook state when the notes pane appears', (
    tester,
  ) async {
    _setViewport(tester, width: _splitBreakpoint - 1);
    addTearDown(() => _resetViewport(tester));

    await tester.pumpWidget(_buildShell(const _StatefulNotebook()));
    await tester.tap(find.text('Increment'));
    await tester.pump();
    expect(find.text('Count: 1'), findsOneWidget);

    _setViewport(tester, width: _splitBreakpoint);
    await tester.pump();

    expect(find.byType(GeneratedNotesPanel), findsOneWidget);
    expect(find.text('Count: 1'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(_notebookKey)).width,
      LeapBreakpoints.expanded,
    );
  });

  testWidgets('preserves notebook state when resizing below again', (
    tester,
  ) async {
    _setViewport(tester, width: 2000);
    addTearDown(() => _resetViewport(tester));

    await tester.pumpWidget(_buildShell(const _StatefulNotebook()));
    await tester.tap(find.text('Increment'));
    await tester.pump();
    expect(find.text('Count: 1'), findsOneWidget);
    expect(find.byType(GeneratedNotesPanel), findsOneWidget);

    _setViewport(tester, width: _splitBreakpoint - 1);
    await tester.pump();

    expect(find.byType(GeneratedNotesPanel), findsNothing);
    expect(find.text('Count: 1'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(_notebookKey)).width,
      _splitBreakpoint - 1,
    );
  });

  testWidgets('uses the preferred notes fraction when there is room', (
    tester,
  ) async {
    _setViewport(tester, width: 2000);
    addTearDown(() => _resetViewport(tester));

    await tester.pumpWidget(_buildShell(const SizedBox(key: _notebookKey)));

    expect(find.byType(GeneratedNotesPanel), findsOneWidget);
    expect(tester.getSize(find.byType(GeneratedNotesPanel)).width, 700);
    expect(tester.getSize(find.byKey(_notebookKey)).width, 1299);
  });

  testWidgets('does not send notes-pane taps to the notebook', (tester) async {
    var notebookTaps = 0;
    _setViewport(tester, width: _splitBreakpoint);
    addTearDown(() => _resetViewport(tester));

    await tester.pumpWidget(
      _buildShell(_PointerNotebook(onTap: () => notebookTaps++)),
    );

    await tester.tapAt(const Offset(100, 100));
    await tester.pump();
    expect(notebookTaps, 1);

    await tester.tapAt(const Offset(1210, 100));
    await tester.pump();
    expect(notebookTaps, 1);
  });

  testWidgets('generated notes panel does not overflow at short heights', (
    tester,
  ) async {
    _setViewport(tester, width: 600, height: 240);
    addTearDown(() => _resetViewport(tester));

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: GeneratedNotesPanel())),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}

Widget _buildShell(Widget notebook) {
  return MaterialApp(
    home: Scaffold(body: LectureShell(notebook: notebook)),
  );
}

void _setViewport(
  WidgetTester tester, {
  required double width,
  double height = 900,
}) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, height);
}

void _resetViewport(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

class _PointerNotebook extends StatelessWidget {
  const _PointerNotebook({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _notebookKey,
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: const SizedBox.expand(),
    );
  }
}

class _StatefulNotebook extends StatefulWidget {
  const _StatefulNotebook();

  @override
  State<_StatefulNotebook> createState() => _StatefulNotebookState();
}

class _StatefulNotebookState extends State<_StatefulNotebook> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      key: _notebookKey,
      color: Colors.transparent,
      child: Column(
        children: [
          Text('Count: $_count'),
          TextButton(
            onPressed: () => setState(() => _count++),
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}
