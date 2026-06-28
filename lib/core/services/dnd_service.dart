import 'package:flutter/services.dart';

class DndService {
  static const MethodChannel _channel = MethodChannel('com.zenith/dnd');

  static const int filterAll = 1; // INTERRUPTION_FILTER_ALL
  static const int filterNone = 3; // INTERRUPTION_FILTER_NONE

  static Future<bool> isNotificationPolicyAccessGranted() async {
    try {
      final bool result = await _channel.invokeMethod('isNotificationPolicyAccessGranted');
      return result;
    } catch (e) {
      return false;
    }
  }

  static Future<void> gotoPolicySettings() async {
    try {
      await _channel.invokeMethod('gotoPolicySettings');
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> setInterruptionFilter(int filter) async {
    try {
      await _channel.invokeMethod('setInterruptionFilter', {'filter': filter});
    } catch (e) {
      // Ignore
    }
  }
}
