import 'package:flutter/material.dart';

import '../data/polije_data.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import '../widgets/info_banner.dart';
import '../widgets/page_scroll.dart';
import '../widgets/section_card.dart';

class PolijePage extends StatefulWidget {
  const PolijePage({super.key});

  @override
  State<PolijePage> createState() => _PolijePageState();
}

class _PolijePageState extends State<PolijePage> {
  Department _selected = departments.firstWhere((d) => d.nameKey == 'd5');

  Widget _title(IconData icon, String text) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );

  Widget _info(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: value),
                ]),
                style: const TextStyle(fontSize: 12.5, height: 1.4),
              ),
            ),
          ],
        ),
      );

  String _prodiLabel(BuildContext context, String p) =>
      p.startsWith('@') ? context.tr(p.substring(1)) : p;

  @override
  Widget build(BuildContext context) {
    final deptName = context.tr(_selected.nameKey);
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        InfoBanner(slides: [
          BannerSlide(Icons.school, context.tr('pb1_t'), context.tr('pb1_d')),
          BannerSlide(Icons.build, context.tr('pb2_t'), context.tr('pb2_d')),
          BannerSlide(Icons.factory, context.tr('pb3_t'), context.tr('pb3_d')),
        ]),

        // 1. Profil POLIJE
        _title(Icons.account_balance, context.tr('pl_profile')),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _info(Icons.badge, context.tr('lbl_name'), context.tr('pl_name')),
              _info(Icons.place, context.tr('lbl_location'),
                  context.tr('pl_address')),
              _info(Icons.category, context.tr('lbl_type'),
                  context.tr('pl_type')),
              _info(Icons.event, context.tr('lbl_founded'),
                  context.tr('pl_founded')),
              _info(Icons.sync_alt, context.tr('lbl_renamed'),
                  context.tr('pl_renamed')),
              _info(Icons.language, context.tr('lbl_website'),
                  PolijeData.website),
              const Divider(),
              Text(context.tr('pl_summary'),
                  style: const TextStyle(fontSize: 12.5, height: 1.45)),
              const SizedBox(height: 10),
              Text(context.tr('pl_vocational'),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              ...List.generate(5, (i) => context.tr('vp${i + 1}')).map(
                (t) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle,
                          size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(t,
                              style: const TextStyle(
                                  fontSize: 12.5, height: 1.4))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Program Studi (Dropdown)
        _title(Icons.menu_book, context.tr('pl_dept_title')),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.tr('pl_pick_dept'),
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textMuted)),
              DropdownButton<Department>(
                isExpanded: true,
                value: _selected,
                items: departments
                    .map((d) => DropdownMenuItem(
                          value: d,
                          child: Row(
                            children: [
                              Icon(d.icon, size: 20, color: AppColors.primary),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Text(context.tr(d.nameKey),
                                      overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selected = v!),
              ),
              const SizedBox(height: 6),
              Text(context.tr('pl_prodi_in', {'d': deptName}),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selected.prodi
                    .map((p) => Chip(
                          label: Text(_prodiLabel(context, p),
                              style: const TextStyle(fontSize: 12)),
                          backgroundColor: AppColors.primary.withAlpha(30),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                          visualDensity: VisualDensity.compact,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              Text(context.tr('pl_prodi_note'),
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
        ),

        // 3. Informasi Program Studi mahasiswa
        _title(Icons.computer, context.tr('pl_my_title')),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _info(Icons.apartment, context.tr('lbl_dept'), context.tr('d5')),
              _info(Icons.school, context.tr('lbl_prodi'),
                  context.tr('my_prodi_name')),
              const Divider(),
              Text(context.tr('pl_my_desc'),
                  style: const TextStyle(fontSize: 12.5, height: 1.45)),
            ],
          ),
        ),

        // 4. Fasilitas & Kegiatan
        _title(Icons.emoji_events, context.tr('pl_fac_title')),
        ...facilities.map(
          (f) => SectionCard(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withAlpha(35),
                  child: Icon(f.icon, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.tr(f.titleKey),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(context.tr(f.descKey),
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Text(
            context.tr('pl_source'),
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}