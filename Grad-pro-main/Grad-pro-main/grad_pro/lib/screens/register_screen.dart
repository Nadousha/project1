import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientTop, AppColors.gradientBottom],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 110,
                    height: 110,
                    color: AppColors.navyCard,
                    child: const Icon(Icons.explore, size: 55, color: AppColors.cyan),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'RA–LINK',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'YOUR AI EGYPT GUIDE',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 13,
                    letterSpacing: 3,
                  ),
                ),

                const SizedBox(height: 28),

                // Register Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.navyCard,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Join and start exploring Egypt',
                        style: TextStyle(color: AppColors.textGrey, fontSize: 14),
                      ),
                      const SizedBox(height: 20),

                      const AppTextField(hint: 'Full name'),
                      const SizedBox(height: 14),
                      const AppTextField(hint: 'Email address'),
                      const SizedBox(height: 14),
                      const AppTextField(hint: 'Password (min 6 chars)', obscure: true),

                      const SizedBox(height: 24),
                      YellowButton(
                        label: 'CREATE ACCOUNT',
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        ),
                      ),

                      const SizedBox(height: 16),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(color: AppColors.textGrey, fontSize: 14),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: AppColors.cyan,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
