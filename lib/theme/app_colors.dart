import 'package:flutter/material.dart';

class AppColors {
  static const Color blue = Color(0xFF3B82F6);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color primary = Color(0xFF4F46E5);
  static const Color background = Color(0xFFF5F7FF);
  static const Color textDark = Color(0xFF1E293B);
  // Abu-abu menengah yang tetap terbaca di mode terang maupun gelap.
  static const Color textMuted = Color(0xFF7A8499);

  // Warna khusus mode gelap
  static const Color darkBackground = Color(0xFF0F1222);
  static const Color darkCard = Color(0xFF1B2036);
  static const Color darkBorder = Color(0xFF2C3352);
  static const Color darkSoft = Color(0xFF232944);

  /// Gradient yang dipakai di AppBar dan Header Profil.
  static const LinearGradient headerGradient = LinearGradient(
    colors: [blue, purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ---- Warna yang menyesuaikan mode terang/gelap ----
  static bool isDark(BuildContext c) =>
      Theme.of(c).brightness == Brightness.dark;

  static Color card(BuildContext c) => isDark(c) ? darkCard : Colors.white;
  static Color border(BuildContext c) =>
      isDark(c) ? darkBorder : const Color(0xFFE5E9F5);
  static Color soft(BuildContext c) =>
      isDark(c) ? darkSoft : const Color(0xFFF8FAFF);
  static Color pageBg(BuildContext c) => isDark(c) ? darkBackground : background;
}