import 'package:flutter/material.dart';

import 'generated_notes_panel.dart';

/// Responsive shell that preserves the existing Butterfly editor as [notebook].
///
/// At expanded widths the generated-notes placeholder occupies roughly 35% of
/// the workspace. At narrower widths CP-2 intentionally leaves the notebook
/// full-width; a compact notes toggle belongs to a later UX checkpoint.
class LectureShell extends StatelessWidget {
  const LectureShell({required this.notebook, super.key});

  final Widget notebook;

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
            SizedBox(width: notesWidth, child: const GeneratedNotesPanel()),
          ],
        );
      },
    );
  }
}
