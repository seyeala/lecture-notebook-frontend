import 'package:flutter/material.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({
    super.key,
    required this.isRecording,
    required this.onRecord,
    required this.onStop,
    this.duration = Duration.zero,
    this.statusText,
  });

  final bool isRecording;
  final VoidCallback? onRecord;
  final VoidCallback? onStop;
  final Duration duration;
  final String? statusText;

  @override
  Widget build(BuildContext context) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final suffix = statusText == null ? '' : ' • $statusText';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonalIcon(
              onPressed: isRecording ? null : onRecord,
              icon: const Icon(Icons.mic_outlined),
              label: const Text('Record'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: isRecording ? onStop : null,
              icon: const Icon(Icons.stop_outlined),
              label: const Text('Stop'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('$minutes:$seconds$suffix', textAlign: TextAlign.center),
      ],
    );
  }
}
