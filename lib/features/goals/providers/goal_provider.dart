import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db.dart';
import '../../../core/repositories/goal_repository.dart';
import '../../../core/models/goal.dart';

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return GoalRepository(isar);
});

final activeGoalsProvider = StateNotifierProvider<GoalsNotifier, AsyncValue<List<Goal>>>((ref) {
  final repo = ref.watch(goalRepositoryProvider);
  return GoalsNotifier(repo);
});

class GoalsNotifier extends StateNotifier<AsyncValue<List<Goal>>> {
  final GoalRepository _repository;

  GoalsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadGoals();
  }

  Future<void> loadGoals() async {
    try {
      final goals = await _repository.getActiveGoals();
      state = AsyncValue.data(goals);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addGoal(String title, String description, DateTime? deadline) async {
    try {
      final goal = Goal()
        ..title = title
        ..description = description
        ..deadline = deadline;
      await _repository.addGoal(goal);
      await loadGoals();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> completeGoal(Goal goal) async {
    try {
      goal.isCompleted = true;
      goal.completedAt = DateTime.now();
      await _repository.updateGoal(goal);
      await loadGoals();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteGoal(int id) async {
    try {
      await _repository.deleteGoal(id);
      await loadGoals();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
