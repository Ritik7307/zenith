import 'package:isar/isar.dart';

part 'timetable_entry.g.dart';

@collection
class TimetableEntry {
  TimetableEntry();

  Id id = Isar.autoIncrement;

  late String subjectName;
  late String location;

  int dayOfWeek = 1; // 1 = Monday, 7 = Sunday

  int startHour = 9;
  int startMinute = 0;

  int endHour = 10;
  int endMinute = 0;

  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'location': location,
      'dayOfWeek': dayOfWeek,
      'startHour': startHour,
      'startMinute': startMinute,
      'endHour': endHour,
      'endMinute': endMinute,
    };
  }

  factory TimetableEntry.fromJson(Map<String, dynamic> json) {
    return TimetableEntry()
      ..subjectName = json['subjectName'] as String
      ..location = json['location'] as String
      ..dayOfWeek = json['dayOfWeek'] as int
      ..startHour = json['startHour'] as int
      ..startMinute = json['startMinute'] as int
      ..endHour = json['endHour'] as int
      ..endMinute = json['endMinute'] as int;
  }
}
