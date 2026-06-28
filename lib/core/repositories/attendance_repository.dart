import 'package:isar/isar.dart';
import '../models/subject.dart';
import '../models/attendance_record.dart';

class AttendanceRepository {
  final Isar isar;

  AttendanceRepository(this.isar);

  Future<List<Subject>> getAllSubjects() async {
    return await isar.subjects.where().findAll();
  }

  Future<void> addSubject(String name, int targetPercentage) async {
    final subject = Subject()
      ..name = name
      ..targetPercentage = targetPercentage;
    
    await isar.writeTxn(() async {
      await isar.subjects.put(subject);
    });
  }

  Future<void> markAttendance(Subject subject, bool isPresent, [DateTime? date]) async {
    final record = AttendanceRecord()
      ..date = date ?? DateTime.now()
      ..isPresent = isPresent;
    
    subject.records = [...subject.records, record];

    await isar.writeTxn(() async {
      await isar.subjects.put(subject);
    });
  }

  Future<void> deleteAttendanceRecord(Subject subject, int recordIndex) async {
    if (recordIndex >= 0 && recordIndex < subject.records.length) {
      final updatedRecords = List<AttendanceRecord>.from(subject.records);
      updatedRecords.removeAt(recordIndex);
      subject.records = updatedRecords;

      await isar.writeTxn(() async {
        await isar.subjects.put(subject);
      });
    }
  }

  Future<void> deleteSubject(int id) async {
    await isar.writeTxn(() async {
      await isar.subjects.delete(id);
    });
  }
}
