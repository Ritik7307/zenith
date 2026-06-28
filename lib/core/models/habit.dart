import 'package:isar/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;

  String name = '';
  String category = '';
  
  int currentStreak = 0;
  int longestStreak = 0;
  
  List<DateTime> completionDates = [];
  
  DateTime createdAt = DateTime.now();
  
  @ignore
  bool get isCompletedToday {
    if (completionDates.isEmpty) return false;
    final last = completionDates.last;
    final now = DateTime.now();
    return last.year == now.year && last.month == now.month && last.day == now.day;
  }
}
