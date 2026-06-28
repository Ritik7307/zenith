import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../dashboard/providers/user_profile_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkProfile();
  }

  Future<void> _checkProfile() async {
    // Wait a brief moment to ensure providers are initialized and to show the splash
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    final profileState = ref.read(userProfileProvider);
    
    // We can also listen to the provider if it's currently loading
    profileState.when(
      data: (user) {
        if (user != null && (user.desiredIdentity ?? '').isNotEmpty) {
          context.go('/dashboard');
        } else {
          context.go('/welcome');
        }
      },
      loading: () {
        // If it's still loading, we will wait until it's done by listening
        ref.listenManual(userProfileProvider, (previous, next) {
          next.whenData((user) {
            if (user != null && (user.desiredIdentity ?? '').isNotEmpty) {
              if (mounted) context.go('/dashboard');
            } else {
              if (mounted) context.go('/welcome');
            }
          });
        });
      },
      error: (_, __) {
        context.go('/welcome');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ZENITH',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    letterSpacing: 8,
                  ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
