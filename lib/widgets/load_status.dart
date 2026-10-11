import 'package:flutter/material.dart';

import '../controllers/portfolio_controller.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import 'section_card.dart';

/// Menampilkan loading / pesan error (dengan tombol Coba Lagi) atau [child].
class LoadStatus extends StatelessWidget {
  final Widget child;
  const LoadStatus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioController.instance;
    if (c.loading && c.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (c.error != null) {
      return SectionCard(
        child: Column(
          children: [
            const Icon(Icons.cloud_off, size: 44, color: Colors.red),
            const SizedBox(height: 8),
            Text(context.tr('load_failed'),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(c.error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textMuted)),
            const SizedBox(height: 10),
            FilledButton.icon(
              style:
                  FilledButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: c.load,
              icon: const Icon(Icons.refresh),
              label: Text(context.tr('retry')),
            ),
          ],
        ),
      );
    }
    return child;
  }
}