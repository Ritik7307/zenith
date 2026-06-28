import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/timetable_provider.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDayProvider);
    final timetableState = ref.watch(timetableProvider);

    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final fullDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('TIMETABLE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Import Timetable',
            onPressed: () {
               _showImportDialog(context, ref);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share Timetable',
            onPressed: () async {
               final repo = ref.read(timetableRepositoryProvider);
               final data = await repo.exportTimetable();
               await Clipboard.setData(ClipboardData(text: data));
               if (context.mounted) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Timetable code copied! Paste it in WhatsApp.')),
                 );
               }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Day Selector
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                final dayNum = index + 1;
                final isSelected = selectedDay == dayNum;
                return GestureDetector(
                  onTap: () {
                    ref.read(selectedDayProvider.notifier).state = dayNum;
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        days[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected 
                              ? Theme.of(context).colorScheme.onPrimary 
                              : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                fullDays[selectedDay - 1],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),

          // Timeline
          Expanded(
            child: timetableState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (entries) {
                if (entries.isEmpty) {
                  return Center(
                    child: Text(
                      'No classes scheduled for today.\nEnjoy your free time!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    
                    final startTime = TimeOfDay(hour: entry.startHour, minute: entry.startMinute);
                    final endTime = TimeOfDay(hour: entry.endHour, minute: entry.endMinute);
                    
                    final now = DateTime.now();
                    final startDt = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
                    final endDt = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
                    
                    final timeFormat = DateFormat('hh:mm a');
                    final timeStr = '${timeFormat.format(startDt)} - ${timeFormat.format(endDt)}';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          entry.subjectName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(timeStr, style: const TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(entry.location),
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                              onPressed: () {
                                _showEditEntryDialog(context, ref, selectedDay, entry);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () {
                                ref.read(timetableProvider.notifier).deleteEntry(entry.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryDialog(context, ref, selectedDay),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  void _showEditEntryDialog(BuildContext context, WidgetRef ref, int selectedDay, dynamic entry) {
    final subjectController = TextEditingController(text: entry.subjectName);
    final locationController = TextEditingController(text: entry.location);
    TimeOfDay startTime = TimeOfDay(hour: entry.startHour, minute: entry.startMinute);
    TimeOfDay endTime = TimeOfDay(hour: entry.endHour, minute: entry.endMinute);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: const Text('Edit Class'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: subjectController,
                      decoration: InputDecoration(
                        hintText: 'Subject Name',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: 'Location (Room/Building)',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Start Time', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () async {
                            final time = await showTimePicker(context: context, initialTime: startTime);
                            if (time != null) setState(() => startTime = time);
                          },
                          child: Text(startTime.format(context)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('End Time', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () async {
                            final time = await showTimePicker(context: context, initialTime: endTime);
                            if (time != null) setState(() => endTime = time);
                          },
                          child: Text(endTime.format(context)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    final name = subjectController.text.trim();
                    final loc = locationController.text.trim();
                    if (name.isNotEmpty) {
                      ref.read(timetableProvider.notifier).updateEntry(
                            entry: entry,
                            subjectName: name,
                            location: loc.isEmpty ? 'TBD' : loc,
                            dayOfWeek: entry.dayOfWeek,
                            startHour: startTime.hour,
                            startMinute: startTime.minute,
                            endHour: endTime.hour,
                            endMinute: endTime.minute,
                          );
                    }
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Save'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showAddEntryDialog(BuildContext context, WidgetRef ref, int selectedDay) {
    final subjectController = TextEditingController();
    final locationController = TextEditingController();
    TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 0);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: const Text('Add Class'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: subjectController,
                      decoration: InputDecoration(
                        hintText: 'Subject Name',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: 'Location (Room/Building)',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Start Time', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () async {
                            final time = await showTimePicker(context: context, initialTime: startTime);
                            if (time != null) setState(() => startTime = time);
                          },
                          child: Text(startTime.format(context)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('End Time', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () async {
                            final time = await showTimePicker(context: context, initialTime: endTime);
                            if (time != null) setState(() => endTime = time);
                          },
                          child: Text(endTime.format(context)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    final name = subjectController.text.trim();
                    final loc = locationController.text.trim();
                    if (name.isNotEmpty) {
                      ref.read(timetableProvider.notifier).addEntry(
                            subjectName: name,
                            location: loc.isEmpty ? 'TBD' : loc,
                            dayOfWeek: selectedDay,
                            startHour: startTime.hour,
                            startMinute: startTime.minute,
                            endHour: endTime.hour,
                            endMinute: endTime.minute,
                          );
                    }
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Add'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showImportDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Import Timetable'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Paste timetable code here',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final data = controller.text.trim();
                if (data.isNotEmpty) {
                  try {
                    await ref.read(timetableRepositoryProvider).importTimetable(data);
                    ref.read(timetableProvider.notifier).loadEntries();
                    if (context.mounted) {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Timetable imported successfully!')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Import failed: $e')),
                      );
                    }
                  }
                }
              },
              child: const Text('Import'),
            ),
          ],
        );
      },
    );
  }
}
