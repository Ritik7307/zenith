import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/user_profile.dart';
import '../../dashboard/providers/user_profile_provider.dart';

class IdentitySetupScreen extends ConsumerStatefulWidget {
  const IdentitySetupScreen({super.key});

  @override
  ConsumerState<IdentitySetupScreen> createState() => _IdentitySetupScreenState();
}

class _IdentitySetupScreenState extends ConsumerState<IdentitySetupScreen> {
  final TextEditingController _identityController = TextEditingController();

  @override
  void dispose() {
    _identityController.dispose();
    super.dispose();
  }

  void _saveAndContinue() async {
    final identity = _identityController.text.trim();
    if (identity.isEmpty) return;

    final profile = UserProfile()..desiredIdentity = identity;
    await ref.read(userProfileProvider.notifier).saveProfile(profile);
    
    if (mounted) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What is your\nname?',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Let\'s personalize your experience.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _identityController,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                decoration: InputDecoration(
                  hintText: 'Enter your name...',
                  hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                onSubmitted: (_) => _saveAndContinue(),
              ),
              const SizedBox(height: 64),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAndContinue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
