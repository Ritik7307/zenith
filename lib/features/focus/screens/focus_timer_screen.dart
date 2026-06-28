import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/focus_provider.dart';

class FocusTimerScreen extends ConsumerWidget {
  const FocusTimerScreen({super.key});

  String _formatTime(int seconds) {
    final m = (seconds / 60).floor().toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLeft = ref.watch(focusTimerProvider);
    final timerNotifier = ref.read(focusTimerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('DEEP FOCUS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Presets
            if (!timerNotifier.isRunning)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPresetButton(context, ref, 15),
                  const SizedBox(width: 8),
                  _buildPresetButton(context, ref, 25),
                  const SizedBox(width: 8),
                  _buildPresetButton(context, ref, 45),
                  const SizedBox(width: 8),
                  _buildPresetButton(context, ref, 60),
                ],
              ),
            const SizedBox(height: 32),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: timerNotifier.isRunning 
                      ? Theme.of(context).colorScheme.primary 
                      : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 8,
                ),
                boxShadow: timerNotifier.isRunning ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    blurRadius: 50,
                    spreadRadius: 10,
                  )
                ] : [],
              ),
              child: Center(
                child: Text(
                  _formatTime(timeLeft),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    timerNotifier.reset();
                  },
                  icon: const Icon(Icons.refresh),
                  iconSize: 32,
                ),
                const SizedBox(width: 32),
                FloatingActionButton.large(
                  onPressed: () {
                    timerNotifier.toggleTimer();
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    timerNotifier.isRunning ? Icons.pause : Icons.play_arrow,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPresetButton(BuildContext context, WidgetRef ref, int minutes) {
    return ActionChip(
      label: Text('${minutes}m'),
      onPressed: () {
        ref.read(focusTimerProvider.notifier).setTime(minutes);
      },
    );
  }
}
