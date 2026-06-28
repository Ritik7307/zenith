import 'package:isar/isar.dart';
import '../models/user_profile.dart';

class UserRepository {
  final Isar isar;

  UserRepository(this.isar);

  Future<UserProfile?> getUserProfile() async {
    return await isar.userProfiles.where().findFirst();
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    await isar.writeTxn(() async {
      profile.updatedAt = DateTime.now();
      await isar.userProfiles.put(profile);
    });
  }
  
  // Zenith Score logic
  String getRank(int score) {
    if (score <= 100) return 'Beginner';
    if (score <= 250) return 'Explorer';
    if (score <= 450) return 'Consistent';
    if (score <= 650) return 'Disciplined';
    if (score <= 800) return 'Elite';
    if (score <= 900) return 'Master';
    return 'Legend';
  }
}
