import 'package:flutter/material.dart';

class AppColors {
  // Primary backgrounds
  static const Color darkNavy = Color(0xFF0A1628);
  static const Color navyCard = Color(0xFF112240);
  static const Color navyLight = Color(0xFF1A3358);

  // Accent colors
  static const Color yellow = Color(0xFFF5C518);
  static const Color yellowLight = Color(0xFFFFD700);
  static const Color cyan = Color(0xFF00C8FF);
  static const Color cyanLight = Color(0xFF4DD9FF);

  // Gradient backgrounds (login/register screens)
  static const Color gradientTop = Color(0xFF1565C0);
  static const Color gradientBottom = Color(0xFF00BCD4);

  // Text colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFF8899AA);
  static const Color textCyan = Color(0xFF00C8FF);
  static const Color textYellow = Color(0xFFF5C518);

  // Input fields
  static const Color inputBorder = Color(0xFF1E3A5F);
  static const Color inputFill = Color(0xFF112240);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.darkNavy,
        fontFamily: 'Poppins',
        colorScheme: const ColorScheme.dark(
          primary: AppColors.yellow,
          secondary: AppColors.cyan,
          surface: AppColors.navyCard,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppColors.textWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: AppColors.textWhite),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.textWhite, fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: AppColors.textWhite, fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: AppColors.textWhite, fontSize: 16),
          bodyMedium: TextStyle(color: AppColors.textGrey, fontSize: 14),
        ),
      );
}

// Reusable widgets
class YellowButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  const YellowButton({
    super.key,
    required this.label,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? AppColors.yellow : AppColors.yellow.withOpacity(0.5),
          foregroundColor: AppColors.darkNavy,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextEditingController? controller;

  const AppTextField({
    super.key,
    required this.hint,
    this.obscure = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: AppColors.textWhite),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textGrey),
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
