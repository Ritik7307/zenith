import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/onboarding/screens/identity_setup_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/focus/screens/focus_timer_screen.dart';
import '../../features/consistency/screens/consistency_screen.dart';
import '../../features/goals/screens/goals_screen.dart';
import '../../features/analytics/screens/analytics_screen.dart';
import '../../features/attendance/screens/attendance_screen.dart';
import '../../features/timetable/screens/timetable_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/core/screens/placeholder_screen.dart';
import '../../features/notes/screens/notes_screen.dart';
import '../../features/events/screens/events_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/identity',
        builder: (context, state) => const IdentitySetupScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/focus',
        builder: (context, state) => const FocusTimerScreen(),
      ),
      GoRoute(
        path: '/consistency',
        builder: (context, state) => const ConsistencyScreen(),
      ),
      GoRoute(
        path: '/goals',
        builder: (context, state) => const GoalsScreen(),
      ),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: '/attendance',
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: '/timetable',
        builder: (context, state) => const TimetableScreen(),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => const NotesScreen(),
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => const EventsScreen(),
      ),
    ],
  );
});
