import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db.dart';
import '../../../core/repositories/timetable_repository.dart';
import '../../../core/models/timetable_entry.dart';

final timetableRepositoryProvider = Provider<TimetableRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return TimetableRepository(isar);
});

final selectedDayProvider = StateProvider<int>((ref) {
  final currentDay = DateTime.now().weekday; 
  return currentDay;
});

final timetableProvider = StateNotifierProvider<TimetableNotifier, AsyncValue<List<TimetableEntry>>>((ref) {
  final repo = ref.watch(timetableRepositoryProvider);
  final day = ref.watch(selectedDayProvider);
  return TimetableNotifier(repo, day);
});

class TimetableNotifier extends StateNotifier<AsyncValue<List<TimetableEntry>>> {
  final TimetableRepository _repository;
  final int _dayOfWeek;

  TimetableNotifier(this._repository, this._dayOfWeek) : super(const AsyncValue.loading()) {
    loadEntries();
  }

  Future<void> loadEntries() async {
    try {
      final entries = await _repository.getEntriesForDay(_dayOfWeek);
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
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
    try {
      await _repository.addEntry(
        subjectName: subjectName,
        location: location,
        dayOfWeek: dayOfWeek,
        startHour: startHour,
        startMinute: startMinute,
        endHour: endHour,
        endMinute: endMinute,
      );
      if (dayOfWeek == _dayOfWeek) {
        await loadEntries();
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateEntry({
    required TimetableEntry entry,
    required String subjectName,
    required String location,
    required int dayOfWeek,
    required int startHour,
    required int startMinute,
    required int endHour,
    required int endMinute,
  }) async {
    try {
      entry.subjectName = subjectName;
      entry.location = location;
      entry.dayOfWeek = dayOfWeek;
      entry.startHour = startHour;
      entry.startMinute = startMinute;
      entry.endHour = endHour;
      entry.endMinute = endMinute;

      await _repository.updateEntry(entry);
      if (dayOfWeek == _dayOfWeek || entry.dayOfWeek == _dayOfWeek) {
        await loadEntries();
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteEntry(int id) async {
    try {
      await _repository.deleteEntry(id);
      await loadEntries();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
