import 'package:flutter/material.dart';

class AppColors {
  static const Color blue = Color(0xFF3B82F6);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color primary = Color(0xFF4F46E5);
  static const Color background = Color(0xFFF5F7FF);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);

  /// Gradient yang dipakai di AppBar dan Header Profil.
  static const LinearGradient headerGradient = LinearGradient(
    colors: [blue, purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}