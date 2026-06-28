import 'dart:convert';
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

  Future<void> updateEntry(TimetableEntry entry) async {
    await isar.writeTxn(() async {
      await isar.timetableEntrys.put(entry);
    });
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

  Future<String> exportTimetable() async {
    final allEntries = await isar.timetableEntrys.where().findAll();
    final jsonList = allEntries.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    final bytes = utf8.encode(jsonString);
    final base64Str = base64Encode(bytes);
    return 'ZENITH-TIMETABLE-$base64Str';
  }

  Future<void> importTimetable(String encodedData) async {
    if (!encodedData.startsWith('ZENITH-TIMETABLE-')) {
      throw Exception('Invalid timetable code.');
    }
    
    final base64Str = encodedData.replaceFirst('ZENITH-TIMETABLE-', '');
    final bytes = base64Decode(base64Str);
    final jsonString = utf8.decode(bytes);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    
    final entries = jsonList.map((e) => TimetableEntry.fromJson(e)).toList();

    await isar.writeTxn(() async {
      await isar.timetableEntrys.putAll(entries);
    });
  }
}
