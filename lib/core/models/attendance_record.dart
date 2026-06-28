import 'package:isar/isar.dart';

part 'attendance_record.g.dart';

@embedded
class AttendanceRecord {
  DateTime? date;
  bool? isPresent;
}
