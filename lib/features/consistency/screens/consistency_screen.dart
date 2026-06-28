import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/habit_provider.dart';

import '../../dashboard/providers/user_profile_provider.dart';

class ConsistencyScreen extends ConsumerWidget {
  const ConsistencyScreen({super.key});

  void _toggleAndScore(WidgetRef ref, habit, bool isCompleted) {
    ref.read(habitsProvider.notifier).toggleHabitCompletion(habit);
    if (isCompleted) {
      ref.read(userProfileProvider.notifier).addPoints(-10);
    } else {
      ref.read(userProfileProvider.notifier).addPoints(10);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsState = ref.watch(habitsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('CONSISTENCY'),
      ),
      body: habitsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (habits) {
          if (habits.isEmpty) {
            return Center(
              child: Text(
                'No habits defined.\nStart building your consistency.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              final isCompleted = habit.isCompletedToday;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isCompleted 
                        ? Theme.of(context).colorScheme.primary 
                        : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  title: Text(
                    habit.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'complete') {
                            _toggleAndScore(ref, habit, isCompleted);
                          } else if (value == 'edit') {
                            _showEditHabitDialog(context, ref, habit);
                          } else if (value == 'delete') {
                            ref.read(habitsProvider.notifier).deleteHabit(habit.id);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'complete',
                            child: Text(isCompleted ? 'Mark Incomplete' : 'Mark Complete'),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          _toggleAndScore(ref, habit, isCompleted);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted ? Theme.of(context).colorScheme.primary : Colors.transparent,
                            border: Border.all(
                              color: isCompleted ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: isCompleted
                              ? Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.onPrimary)
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context, ref),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Habit'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'E.g., Read 10 pages'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty) {
                  ref.read(habitsProvider.notifier).addHabit(name);
                }
                context.pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditHabitDialog(BuildContext context, WidgetRef ref, habit) {
    final controller = TextEditingController(text: habit.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Habit'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Habit name'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty && name != habit.name) {
                  ref.read(habitsProvider.notifier).editHabit(habit, name);
                }
                context.pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
