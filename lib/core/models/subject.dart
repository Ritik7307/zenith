import 'package:isar/isar.dart';
import 'attendance_record.dart';

part 'subject.g.dart';

@collection
class Subject {
  Id id = Isar.autoIncrement;

  late String name;

  int targetPercentage = 75; // Default 75% attendance required

  List<AttendanceRecord> records = [];

  int get totalClasses => records.length;
  
  int get attendedClasses => records.where((r) => r.isPresent == true).length;

  double get currentPercentage {
    if (totalClasses == 0) return 100.0; // Default to 100% if no classes yet
    return (attendedClasses / totalClasses) * 100;
  }
}
