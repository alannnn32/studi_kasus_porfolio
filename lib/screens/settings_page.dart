import 'package:flutter/material.dart';

import '../controllers/portfolio_controller.dart';
import '../controllers/settings_controller.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/page_scroll.dart';
import '../widgets/section_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  /// Jalankan aksi ke server, lalu tampilkan hasilnya.
  Future<void> _run(BuildContext context, Future<void> Function() action,
      String okMessage) async {
    String msg = okMessage;
    try {
      await action();
    } catch (e) {
      msg = e.toString().replaceFirst('Exception: ', '');
    }
    if (context.mounted) _snack(context, msg);
  }

  Widget _sectionTitle(IconData icon, String text) => Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Text(text,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final c = PortfolioController.instance;
    final s = SettingsController.instance;
    return PageScroll(
      children: [
        const SizedBox(height: 8),

        // ---------- Tampilan & Bahasa ----------
        SectionCard(
          child: ListenableBuilder(
            listenable: s,
            builder: (context, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(Icons.palette, context.tr('s_appearance')),
                const SizedBox(height: 12),
                Text(context.tr('s_theme_mode'),
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMuted)),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: const Icon(Icons.light_mode),
                        label: Text(context.tr('theme_light')),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: const Icon(Icons.dark_mode),
                        label: Text(context.tr('theme_dark')),
                      ),
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: const Icon(Icons.phone_android),
                        label: Text(context.tr('theme_system')),
                      ),
                    ],
                    selected: {s.themeMode},
                    onSelectionChanged: (v) => s.setThemeMode(v.first),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.translate,
                        color: AppColors.primary, size: 18),
                    const SizedBox(width: 6),
                    Text(context.tr('s_language'),
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textMuted)),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                          value: 'id', label: Text(context.tr('lang_id'))),
                      ButtonSegment(
                          value: 'en', label: Text(context.tr('lang_en'))),
                    ],
                    selected: {s.lang},
                    onSelectionChanged: (v) => s.setLang(v.first),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ---------- Data ----------
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(Icons.storage, context.tr('s_data')),
              const SizedBox(height: 4),
              ListenableBuilder(
                listenable: c,
                builder: (_, __) => Text(
                  context.tr('s_total', {'n': '${c.items.length}'}),
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.refresh, color: AppColors.primary),
                title: Text(context.tr('s_reload')),
                subtitle: Text(context.tr('s_reload_sub')),
                onTap: () async {
                  await c.load();
                  if (context.mounted) {
                    _snack(context, c.error ?? context.tr('s_reload_ok'));
                  }
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.restore, color: AppColors.primary),
                title: Text(context.tr('s_reset')),
                subtitle: Text(context.tr('s_reset_sub')),
                onTap: () async {
                  final ok = await confirmDialog(
                    context,
                    title: context.tr('reset_title'),
                    message: context.tr('reset_msg'),
                    confirmText: context.tr('reset_btn'),
                  );
                  if (!ok || !context.mounted) return;
                  await _run(context, c.resetToSeed, context.tr('reset_ok'));
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: Text(context.tr('s_delete_all')),
                subtitle: Text(context.tr('s_delete_all_sub')),
                onTap: () async {
                  final ok = await confirmDialog(
                    context,
                    title: context.tr('delete_all_title'),
                    message: context.tr('delete_all_msg'),
                  );
                  if (!ok || !context.mounted) return;
                  await _run(
                      context, c.removeAll, context.tr('delete_all_ok'));
                },
              ),
            ],
          ),
        ),

        // ---------- Tentang aplikasi ----------
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(Icons.info_outline, context.tr('s_about_app')),
              const SizedBox(height: 8),
              Text(context.tr('app_title'),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(context.tr('version'),
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textMuted)),
              const SizedBox(height: 6),
              Text(context.tr('app_desc'),
                  style: const TextStyle(fontSize: 12.5, height: 1.4)),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}