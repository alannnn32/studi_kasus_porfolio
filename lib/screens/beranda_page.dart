import 'package:flutter/material.dart';

import '../controllers/portfolio_controller.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import '../widgets/info_banner.dart';
import '../widgets/load_status.dart';
import '../widgets/page_scroll.dart';
import '../widgets/profile_header.dart';
import '../widgets/project_pager.dart';
import '../widgets/section_card.dart';

class BerandaPage extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  final VoidCallback onAdd;

  const BerandaPage({super.key, required this.onNavigate, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: PortfolioController.instance,
      builder: (context, _) {
        final items = PortfolioController.instance.items;
        final techs = items
            .expand((p) => p.tech.split(','))
            .map((t) => t.trim().toLowerCase())
            .where((t) => t.isNotEmpty)
            .toSet();
        final cats = items.map((p) => p.category).toSet();

        return PageScroll(
          children: [
            const ProfileHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _stat(Icons.folder, '${items.length}',
                      context.tr('stat_works')),
                  _stat(Icons.category, '${cats.length}',
                      context.tr('stat_categories')),
                  _stat(Icons.layers, '${techs.length}',
                      context.tr('stat_tech')),
                ],
              ),
            ),
            const SizedBox(height: 8),
            InfoBanner(slides: [
              BannerSlide(Icons.waving_hand, context.tr('banner1_t'),
                  context.tr('banner1_d')),
              BannerSlide(Icons.folder_special, context.tr('banner2_t'),
                  context.tr('banner2_d')),
              BannerSlide(Icons.school, context.tr('banner3_t'),
                  context.tr('banner3_d')),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  const Icon(Icons.work, color: AppColors.primary, size: 22),
                  const SizedBox(width: 8),
                  Text(context.tr('latest_works'),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            LoadStatus(child: ProjectPager(projects: items.take(5).toList())),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onAdd,
                      icon: const Icon(Icons.add),
                      label: Text(context.tr('btn_add_work')),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white),
                      onPressed: () => onNavigate(3),
                      icon: const Icon(Icons.school),
                      label: Text(context.tr('btn_about_polije')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _stat(IconData icon, String value, String label) {
    return Expanded(
      child: SectionCard(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}