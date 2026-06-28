import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db.dart';
import '../../../core/repositories/habit_repository.dart';
import '../../../core/models/habit.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return HabitRepository(isar);
});

final habitsProvider = StateNotifierProvider<HabitsNotifier, AsyncValue<List<Habit>>>((ref) {
  final repo = ref.watch(habitRepositoryProvider);
  return HabitsNotifier(repo);
});

class HabitsNotifier extends StateNotifier<AsyncValue<List<Habit>>> {
  final HabitRepository _repository;

  HabitsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadHabits();
  }

  Future<void> loadHabits() async {
    try {
      final habits = await _repository.getAllHabits();
      state = AsyncValue.data(habits);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addHabit(String name) async {
    try {
      final habit = Habit()..name = name;
      await _repository.addHabit(habit);
      await loadHabits();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleHabitCompletion(Habit habit) async {
    try {
      final today = DateTime.now();
      bool completed = habit.isCompletedToday;
      
      if (completed) {
        habit.completionDates.removeWhere((d) => 
          d.year == today.year && d.month == today.month && d.day == today.day);
      } else {
        habit.completionDates.add(today);
      }
      
      await _repository.updateHabit(habit);
      await loadHabits();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> editHabit(Habit habit, String newName) async {
    try {
      habit.name = newName;
      await _repository.updateHabit(habit);
      await loadHabits();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> deleteHabit(int id) async {
    try {
      await _repository.deleteHabit(id);
      await loadHabits();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
