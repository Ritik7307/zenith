import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/scheduled_event.dart';
import '../services/local_db.dart';
import '../services/notification_service.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final isar = ref.watch(isarProvider);
  final notificationService = ref.watch(notificationServiceProvider);
  return EventRepository(isar, notificationService);
});

class EventRepository {
  final Isar _isar;
  final NotificationService _notificationService;

  EventRepository(this._isar, this._notificationService);

  Future<void> addEvent(String title, String description, DateTime scheduledTime) async {
    final event = ScheduledEvent()
      ..title = title
      ..description = description
      ..scheduledTime = scheduledTime
      ..isNotified = false;

    await _isar.writeTxn(() async {
      await _isar.scheduledEvents.put(event);
    });

    _notificationService.scheduleNotification(
      id: event.id,
      title: event.title,
      body: event.description,
      scheduledDate: event.scheduledTime,
    );
  }

  Future<void> deleteEvent(int id) async {
    await _isar.writeTxn(() async {
      await _isar.scheduledEvents.delete(id);
    });
    _notificationService.cancelNotification(id);
  }

  Stream<List<ScheduledEvent>> watchEvents() {
    return _isar.scheduledEvents.where().sortByScheduledTime().watch(fireImmediately: true);
  }
}
