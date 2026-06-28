import 'package:isar/isar.dart';
import '../models/habit.dart';

class HabitRepository {
  final Isar isar;

  HabitRepository(this.isar);

  Future<List<Habit>> getAllHabits() async {
    return await isar.habits.where().findAll();
  }

  Future<void> addHabit(Habit habit) async {
    await isar.writeTxn(() async {
      await isar.habits.put(habit);
    });
  }

  Future<void> updateHabit(Habit habit) async {
    await isar.writeTxn(() async {
      await isar.habits.put(habit);
    });
  }

  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
  }
}
