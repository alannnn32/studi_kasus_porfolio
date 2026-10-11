import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pengaturan tampilan (mode terang/gelap) dan bahasa. Disimpan permanen.
class SettingsController extends ChangeNotifier {
  SettingsController._();
  static final SettingsController instance = SettingsController._();

  static const _kTheme = 'theme_mode';
  static const _kLang = 'language';

  ThemeMode themeMode = ThemeMode.light;
  String lang = 'id';

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final t = prefs.getString(_kTheme);
      themeMode = ThemeMode.values.firstWhere(
        (m) => m.name == t,
        orElse: () => ThemeMode.light,
      );
      final l = prefs.getString(_kLang);
      if (l == 'id' || l == 'en') lang = l!;
    } catch (_) {
      // gagal membaca: pakai nilai bawaan
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    try {
      (await SharedPreferences.getInstance()).setString(_kTheme, mode.name);
    } catch (_) {}
  }

  Future<void> setLang(String code) async {
    lang = code;
    notifyListeners();
    try {
      (await SharedPreferences.getInstance()).setString(_kLang, code);
    } catch (_) {}
  }
}