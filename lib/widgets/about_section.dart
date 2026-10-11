import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import 'section_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person, color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text('Tentang Saya',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            ProfileData.about,
            style: TextStyle(
                fontSize: 12.5, height: 1.45, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) {
              return Chip(
                avatar: Icon(techIcons[s], size: 16, color: AppColors.primary),
                label: Text(s, style: const TextStyle(fontSize: 12)),
                backgroundColor: AppColors.primary.withAlpha(20),
                side: BorderSide.none,
                shape: const StadiumBorder(),
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}