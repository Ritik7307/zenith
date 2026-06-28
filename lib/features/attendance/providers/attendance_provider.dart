import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db.dart';
import '../../../core/repositories/attendance_repository.dart';
import '../../../core/models/subject.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return AttendanceRepository(isar);
});

final attendanceProvider = StateNotifierProvider<AttendanceNotifier, AsyncValue<List<Subject>>>((ref) {
  final repo = ref.watch(attendanceRepositoryProvider);
  return AttendanceNotifier(repo);
});

class AttendanceNotifier extends StateNotifier<AsyncValue<List<Subject>>> {
  final AttendanceRepository _repository;

  AttendanceNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadSubjects();
  }

  Future<void> loadSubjects() async {
    try {
      final subjects = await _repository.getAllSubjects();
      state = AsyncValue.data(subjects);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSubject(String name, int targetPercentage) async {
    try {
      await _repository.addSubject(name, targetPercentage);
      await loadSubjects();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markAttendance(Subject subject, bool isPresent, [DateTime? date]) async {
    try {
      await _repository.markAttendance(subject, isPresent, date);
      await loadSubjects();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAttendanceRecord(Subject subject, int recordIndex) async {
    try {
      await _repository.deleteAttendanceRecord(subject, recordIndex);
      await loadSubjects();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteSubject(int id) async {
    try {
      await _repository.deleteSubject(id);
      await loadSubjects();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
