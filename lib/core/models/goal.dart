import 'package:isar/isar.dart';

part 'goal.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;

  String title = '';
  String description = '';
  
  DateTime? deadline;
  DateTime createdAt = DateTime.now();
  
  bool isCompleted = false;
  DateTime? completedAt;
}
