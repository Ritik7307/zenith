import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  String? name;
  String? desiredIdentity; // e.g. "Software Engineer"
  List<String>? focusAreas; // e.g. ["Career", "Fitness"]
  
  // Zenith Score Components
  int zenithScore = 0; // 0-1000
  double consistencyPercentage = 0.0;
  int currentStreak = 0;
  int bestStreak = 0;
  
  // Stats
  int totalFocusMinutes = 0;
  int problemsSolved = 0;
  
  // Meta
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
