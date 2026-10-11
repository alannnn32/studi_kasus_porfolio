import 'package:flutter/material.dart';

import '../controllers/portfolio_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/info_banner.dart';
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
                  _stat(Icons.folder, '${items.length}', 'Karya'),
                  _stat(Icons.category, '${cats.length}', 'Kategori'),
                  _stat(Icons.layers, '${techs.length}', 'Teknologi'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const InfoBanner(slides: [
              BannerSlide(Icons.waving_hand, 'Selamat Datang!',
                  'Ini portofolio digital saya: profil, karya, dan informasi kampus.'),
              BannerSlide(Icons.folder_special, 'Karya Saya',
                  'Lihat, tambah, ubah, dan hapus karya di menu Portofolio.'),
              BannerSlide(Icons.school, 'Kenali POLIJE',
                  'Politeknik Negeri Jember: kampus vokasi di Jember, Jawa Timur.'),
            ]),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Icon(Icons.work, color: AppColors.primary, size: 22),
                  SizedBox(width: 8),
                  Text('Karya Terbaru',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ProjectPager(projects: items.take(5).toList()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onAdd,
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Karya'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary),
                      onPressed: () => onNavigate(3),
                      icon: const Icon(Icons.school),
                      label: const Text('Tentang POLIJE'),
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
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}