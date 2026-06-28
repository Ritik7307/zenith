import 'package:isar/isar.dart';

part 'scheduled_event.g.dart';

@collection
class ScheduledEvent {
  Id id = Isar.autoIncrement;

  late String title;
  
  late String description;

  late DateTime scheduledTime;

  bool isNotified = false;
}
