import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../dashboard/providers/user_profile_provider.dart';
import '../../consistency/providers/habit_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userProfileProvider).value;
      if (user != null) {
        _nameController.text = user.desiredIdentity ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      final user = ref.read(userProfileProvider).value;
      if (user != null) {
        user.desiredIdentity = newName;
        ref.read(userProfileProvider.notifier).saveProfile(user);
      }
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final habitsState = ref.watch(habitsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('PROFILE'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Editable Name Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'YOUR NAME',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              letterSpacing: 2,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            ),
                      ),
                      IconButton(
                        icon: Icon(_isEditing ? Icons.check : Icons.edit),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          if (_isEditing) {
                            _saveName();
                          } else {
                            setState(() {
                              _isEditing = true;
                            });
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isEditing)
                    TextField(
                      controller: _nameController,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter your name...',
                      ),
                      onSubmitted: (_) => _saveName(),
                      autofocus: true,
                    )
                  else
                    Text(
                      _nameController.text.isEmpty ? 'Loading...' : _nameController.text,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Heatmap
            habitsState.when(
              data: (habits) => _buildHeatMap(context, habits),
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeatMap(BuildContext context, habits) {
    // Generate last 30 days
    final today = DateTime.now();
    final last30Days = List.generate(30, (index) => today.subtract(Duration(days: 29 - index)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PROGRESS HEAP (30 DAYS)',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                letterSpacing: 2,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: last30Days.map((date) {
              // Calculate completion percentage for this day
              int completed = 0;
              for (final habit in habits) {
                if (habit.completionDates.any((d) => d.year == date.year && d.month == date.month && d.day == date.day)) {
                  completed++;
                }
              }
              final total = habits.length;
              final percent = total > 0 ? completed / total : 0.0;

              Color color;
              if (percent == 0) {
                color = Theme.of(context).colorScheme.primary.withOpacity(0.05);
              } else if (percent < 0.5) {
                color = Theme.of(context).colorScheme.primary.withOpacity(0.3);
              } else if (percent < 1.0) {
                color = Theme.of(context).colorScheme.primary.withOpacity(0.6);
              } else {
                color = Theme.of(context).colorScheme.primary;
              }

              return Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
