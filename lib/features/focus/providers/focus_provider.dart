import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/dnd_service.dart';

final focusTimerProvider = StateNotifierProvider<FocusTimerNotifier, int>((ref) {
  return FocusTimerNotifier();
});

class FocusTimerNotifier extends StateNotifier<int> {
  int _initialTime = 25 * 60;
  Timer? _timer;
  bool _isRunning = false;

  FocusTimerNotifier() : super(25 * 60); // 25 minutes default

  bool get isRunning => _isRunning;

  void setTime(int minutes) {
    if (_isRunning) return;
    _initialTime = minutes * 60;
    state = _initialTime;
  }

  Future<void> _setDND(bool enable) async {
    bool hasAccess = await DndService.isNotificationPolicyAccessGranted();
    if (hasAccess) {
      if (enable) {
        await DndService.setInterruptionFilter(DndService.filterNone);
      } else {
        await DndService.setInterruptionFilter(DndService.filterAll);
      }
    }
  }

  void toggleTimer() async {
    if (_isRunning) {
      _timer?.cancel();
      await _setDND(false);
    } else {
      bool hasAccess = await DndService.isNotificationPolicyAccessGranted();
      if (!hasAccess) {
        DndService.gotoPolicySettings();
      } else {
        await _setDND(true);
      }

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (state > 0) {
          state--;
        } else {
          timer.cancel();
          _isRunning = false;
          await _setDND(false);
        }
      });
    }
    _isRunning = !_isRunning;
  }

  void reset() async {
    _timer?.cancel();
    _isRunning = false;
    state = _initialTime;
    await _setDND(false);
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _setDND(false);
    super.dispose();
  }
}
