import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user_profile.dart';
import '../models/habit.dart';
import '../models/focus_session.dart';
import '../models/goal.dart';

import '../models/subject.dart';
import '../models/timetable_entry.dart';
import '../models/note.dart';
import '../models/scheduled_event.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar database is not initialized yet');
});

class LocalDBService {
  static late Isar _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserProfileSchema, HabitSchema, FocusSessionSchema, GoalSchema, SubjectSchema, TimetableEntrySchema, NoteSchema, ScheduledEventSchema],
      directory: dir.path,
    );
  }

  static Isar get instance => _isar;
}
