import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_profile_provider.dart';
import '../../../core/theme/theme_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProfileProvider);
    final repo = ref.watch(userRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ZENITH'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            tooltip: 'How to use Zenith',
            onPressed: () => _showHelpDialog(context),
          ),
          IconButton(
            icon: Icon(
              ref.watch(themeModeProvider) == ThemeMode.dark 
                ? Icons.light_mode 
                : Icons.dark_mode,
            ),
            onPressed: () {
              final current = ref.read(themeModeProvider);
              if (current == ThemeMode.dark) {
                ref.read(themeModeProvider.notifier).state = ThemeMode.light;
              } else if (current == ThemeMode.light) {
                ref.read(themeModeProvider.notifier).state = ThemeMode.system;
              } else {
                ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
          )
        ],
      ),
      body: userState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (user) {
          final identity = user?.desiredIdentity ?? 'Future Engineer';
          final score = user?.zenithScore ?? 0;
          final rank = repo.getRank(score);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back, $identity.',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your journey to greatness continues.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Modules',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildModuleCard(context, 'Timetable', Icons.schedule, () => context.push('/timetable')),
                    _buildModuleCard(context, 'Attendance', Icons.school, () => context.push('/attendance')),
                    _buildModuleCard(context, 'Consistency', Icons.calendar_month, () => context.push('/consistency')),
                    _buildModuleCard(context, 'Deep Focus', Icons.timer, () => context.push('/focus')),
                    _buildModuleCard(context, 'Goals', Icons.flag, () => context.push('/goals')),
                    _buildModuleCard(context, 'Analytics', Icons.bar_chart, () => context.push('/analytics')),
                    _buildModuleCard(context, 'Notes', Icons.note, () => context.push('/notes')),
                    _buildModuleCard(context, 'Events', Icons.event, () => context.push('/events')),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber),
              SizedBox(width: 8),
              Text('How to use Zenith'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Zenith is your ultimate productivity companion. Here is how to use the modules:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Timetable', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Plan your weekly classes. You can add, edit, and delete classes for each day of the week. Use the export button in the top right to copy a code that you can share with your friends, allowing them to import your exact schedule.'),
                SizedBox(height: 12),
                Text('Attendance', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Keep track of your classes to maintain the perfect 75% criteria. Tap on a subject to mark yourself present or absent for the day. The module will automatically calculate your overall percentage.'),
                SizedBox(height: 12),
                Text('Consistency', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Build strong habits by checking in daily. Simply open the app and log your consistency to maintain your streak. Do not break the chain!'),
                SizedBox(height: 12),
                Text('Deep Focus', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('A dedicated Pomodoro timer to help you concentrate without distractions. Start the timer, put your phone away, and focus entirely on your task until the time is up.'),
                SizedBox(height: 12),
                Text('Goals', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Set both short-term and long-term objectives. You can set specific target dates for each goal and mark them as complete as you progress. This helps you stay motivated and on track.'),
                SizedBox(height: 12),
                Text('Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('View your overall progress, streaks, and Zenith Score in one place. Your score increases as you maintain consistency and complete goals.'),
                SizedBox(height: 12),
                Text('Notes', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('A simple workspace to jot down quick thoughts, save important links, or write detailed lecture notes. You can edit or delete them at any time.'),
                SizedBox(height: 12),
                Text('Events', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Schedule one-off events or important reminders. Select a specific date and time, and the app will trigger an exact alarm to notify you, even if the app is closed or your phone is completely offline.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }
}

