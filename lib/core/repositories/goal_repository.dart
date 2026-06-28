import 'package:isar/isar.dart';
import '../models/goal.dart';

class GoalRepository {
  final Isar isar;

  GoalRepository(this.isar);

  Future<List<Goal>> getActiveGoals() async {
    return await isar.goals.filter().isCompletedEqualTo(false).findAll();
  }
  
  Future<List<Goal>> getCompletedGoals() async {
    return await isar.goals.filter().isCompletedEqualTo(true).findAll();
  }

  Future<void> addGoal(Goal goal) async {
    await isar.writeTxn(() async {
      await isar.goals.put(goal);
    });
  }

  Future<void> updateGoal(Goal goal) async {
    await isar.writeTxn(() async {
      await isar.goals.put(goal);
    });
  }

  Future<void> deleteGoal(int id) async {
    await isar.writeTxn(() async {
      await isar.goals.delete(id);
    });
  }
}
