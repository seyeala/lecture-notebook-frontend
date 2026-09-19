import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

import 'generated_notes_panel.dart';

/// Responsive shell that preserves the existing Butterfly editor as [notebook].
///
/// The generated-notes pane is shown only when the workspace is wide enough
/// to keep the notebook at Butterfly's existing expanded breakpoint. This
/// prevents the split itself from forcing the editor into its compact layout.
class LectureShell extends StatelessWidget {
  const LectureShell({required this.notebook, super.key});

  final Widget notebook;

  static const double _notesFraction = 0.35;
  static const double _minimumNotesWidth = 320;
  static const double _dividerWidth = 1;
  static const double _splitBreakpoint =
      LeapBreakpoints.expanded + _minimumNotesWidth + _dividerWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showNotes = constraints.maxWidth >= _splitBreakpoint;
        final notesWidth = showNotes
            ? math.min(
                constraints.maxWidth * _notesFraction,
                constraints.maxWidth - LeapBreakpoints.expanded - _dividerWidth,
              )
            : 0.0;

        return Row(
          children: [
            Expanded(child: notebook),
            if (showNotes) ...[
              const VerticalDivider(width: _dividerWidth, thickness: 1),
              SizedBox(width: notesWidth, child: const GeneratedNotesPanel()),
            ],
          ],
        );
      },
    );
  }
}
