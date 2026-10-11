import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controllers/portfolio_controller.dart';
import 'controllers/settings_controller.dart';
import 'l10n/app_strings.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muat pengaturan (tema & bahasa) lebih dulu agar tidak berkedip.
  await SettingsController.instance.load();
  // Data karya dimuat dari server (MySQL via PHP); status loading/error
  // ditampilkan oleh LoadStatus.
  PortfolioController.instance.load();
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: SettingsController.instance,
      builder: (context, _) {
        final s = SettingsController.instance;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (ctx) => ctx.tr('app_title'),
          theme: buildTheme(Brightness.light),
          darkTheme: buildTheme(Brightness.dark),
          themeMode: s.themeMode,
          locale: Locale(s.lang),
          supportedLocales: const [Locale('id'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const HomeScreen(),
        );
      },
    );
  }
}