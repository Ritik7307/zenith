import 'package:isar/isar.dart';

part 'focus_session.g.dart';

@collection
class FocusSession {
  Id id = Isar.autoIncrement;

  int durationMinutes = 0;
  String type = 'pomodoro'; 
  
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  
  bool wasCompleted = false;
  String notes = '';
}
