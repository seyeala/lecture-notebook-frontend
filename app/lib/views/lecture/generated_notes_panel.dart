import 'package:flutter/material.dart';

class GeneratedNotesPanel extends StatelessWidget {
  const GeneratedNotesPanel({
    super.key,
    this.onCaptureSession,
    this.captureInProgress = false,
    this.lastCaptureSummary,
  });

  final Future<void> Function()? onCaptureSession;
  final bool captureInProgress;
  final String? lastCaptureSummary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      child: SafeArea(
        left: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
              child: Row(
                children: [
                  const Icon(Icons.description_outlined),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Generated Notes',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const Chip(label: Text('Local')),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.picture_as_pdf_outlined,
                          size: 56,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No generated PDF yet',
                          style: theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'CP-3 can capture a local notebook snapshot and '
                          'manifest. Nothing is uploaded.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: captureInProgress
                              ? null
                              : () => onCaptureSession?.call(),
                          icon: captureInProgress
                              ? const SizedBox.square(
                                  dimension: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.inventory_2_outlined),
                          label: const Text('Capture Session'),
                        ),
                        if (lastCaptureSummary != null) ...[
                          const SizedBox(height: 16),
                          SelectableText(
                            lastCaptureSummary!,
                            style: theme.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const SizedBox(height: 12),
                        const FilledButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.auto_awesome_outlined),
                          label: Text('Generate Notes'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
