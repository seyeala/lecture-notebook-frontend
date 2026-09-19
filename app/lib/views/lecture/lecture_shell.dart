import 'package:flutter/material.dart';

import 'generated_notes_panel.dart';

class LectureShell extends StatelessWidget {
  const LectureShell({
    required this.notebook,
    super.key,
    this.onCaptureSession,
    this.captureInProgress = false,
    this.lastCaptureSummary,
  });

  final Widget notebook;
  final Future<void> Function()? onCaptureSession;
  final bool captureInProgress;
  final String? lastCaptureSummary;

  static const double _splitBreakpoint = 1000;
  static const double _notesFraction = 0.35;
  static const double _dividerWidth = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _splitBreakpoint) {
          return notebook;
        }

        final notesWidth = constraints.maxWidth * _notesFraction;
        return Row(
          children: [
            Expanded(child: notebook),
            const VerticalDivider(width: _dividerWidth, thickness: 1),
            SizedBox(
              width: notesWidth,
              child: GeneratedNotesPanel(
                onCaptureSession: onCaptureSession,
                captureInProgress: captureInProgress,
                lastCaptureSummary: lastCaptureSummary,
              ),
            ),
          ],
        );
      },
    );
  }
}
