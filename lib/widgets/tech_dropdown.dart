import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import 'section_card.dart';

class TechDropdown extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const TechDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr('tech_label'),
              style:
                  const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selected,
              hint: Text(context.tr('tech_hint')),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: technologies.map((t) {
                return DropdownMenuItem<String>(
                  value: t,
                  child: Row(
                    children: [
                      Icon(techIcons[t], size: 20, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Text(t,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
          if (selected != null) ...[
            const Divider(height: 16),
            Row(
              children: [
                const Icon(Icons.check_circle,
                    size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    context.tr('tech_selected', {'t': selected!}),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}