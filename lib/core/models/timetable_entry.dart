import 'package:isar/isar.dart';

part 'timetable_entry.g.dart';

@collection
class TimetableEntry {
  Id id = Isar.autoIncrement;

  late String subjectName;
  late String location;

  int dayOfWeek = 1; // 1 = Monday, 7 = Sunday

  int startHour = 9;
  int startMinute = 0;

  int endHour = 10;
  int endMinute = 0;
}
