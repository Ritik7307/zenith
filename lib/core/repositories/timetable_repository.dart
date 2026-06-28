import 'package:isar/isar.dart';
import '../models/timetable_entry.dart';

class TimetableRepository {
  final Isar isar;

  TimetableRepository(this.isar);

  Future<List<TimetableEntry>> getEntriesForDay(int dayOfWeek) async {
    return await isar.timetableEntrys
        .where()
        .filter()
        .dayOfWeekEqualTo(dayOfWeek)
        .sortByStartHour()
        .thenByStartMinute()
        .findAll();
  }

  Future<void> addEntry({
    required String subjectName,
    required String location,
    required int dayOfWeek,
    required int startHour,
    required int startMinute,
    required int endHour,
    required int endMinute,
  }) async {
    final entry = TimetableEntry()
      ..subjectName = subjectName
      ..location = location
      ..dayOfWeek = dayOfWeek
      ..startHour = startHour
      ..startMinute = startMinute
      ..endHour = endHour
      ..endMinute = endMinute;
    
    await isar.writeTxn(() async {
      await isar.timetableEntrys.put(entry);
    });
  }

  Future<void> deleteEntry(int id) async {
    await isar.writeTxn(() async {
      await isar.timetableEntrys.delete(id);
    });
  }
}
