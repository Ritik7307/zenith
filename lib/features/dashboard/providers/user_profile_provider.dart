import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db.dart';
import '../../../core/repositories/user_repository.dart';
import '../../../core/models/user_profile.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return UserRepository(isar);
});

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserProfileNotifier(repo);
});

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final UserRepository _repository;

  UserProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _repository.getUserProfile();
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveProfile(UserProfile profile) async {
    state = const AsyncValue.loading();
    try {
      await _repository.saveUserProfile(profile);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addPoints(int points) async {
    final currentProfile = state.value;
    if (currentProfile != null) {
      currentProfile.zenithScore += points;
      // Prevent score from going below 0
      if (currentProfile.zenithScore < 0) {
        currentProfile.zenithScore = 0;
      }
      await saveProfile(currentProfile);
    }
  }
}
