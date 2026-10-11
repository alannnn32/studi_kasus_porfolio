import 'package:flutter/material.dart';

import '../data/polije_data.dart';
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
  Department _selected = departments.firstWhere(
    (d) => d.name == 'Teknologi Informasi',
  );

  Widget _title(IconData icon, String text) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 8),
            Text(text,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: value),
              ]), style: const TextStyle(fontSize: 12.5, height: 1.4)),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        const InfoBanner(slides: [
          BannerSlide(Icons.school, 'Politeknik Negeri Jember',
              'Perguruan tinggi vokasi di Jember, Jawa Timur.'),
          BannerSlide(Icons.build, 'Berbasis Praktik',
              'Pembelajaran berorientasi keahlian dan kesiapan kerja.'),
          BannerSlide(Icons.factory, 'Teaching Factory',
              'Menghubungkan pembelajaran kampus dengan dunia industri.'),
        ]),

        // 1. Profil POLIJE
        _title(Icons.account_balance, 'Profil POLIJE'),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _info(Icons.badge, 'Nama', PolijeData.name),
              _info(Icons.place, 'Lokasi', PolijeData.address),
              _info(Icons.category, 'Jenis', PolijeData.type),
              _info(Icons.event, 'Berdiri', PolijeData.founded),
              _info(Icons.sync_alt, 'Perubahan nama', PolijeData.renamed),
              _info(Icons.language, 'Situs resmi', PolijeData.website),
              const Divider(),
              Text(PolijeData.summary,
                  style: const TextStyle(fontSize: 12.5, height: 1.45)),
              const SizedBox(height: 10),
              const Text('Karakteristik Pendidikan Vokasi',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              ...PolijeData.vocationalPoints.map(
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
        _title(Icons.menu_book, 'Jurusan & Program Studi'),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pilih Jurusan',
                  style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
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
                                  child: Text(d.name,
                                      overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selected = v!),
              ),
              const SizedBox(height: 6),
              Text('Program studi di Jurusan ${_selected.name}:',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selected.prodi
                    .map((p) => Chip(
                          label: Text(p, style: const TextStyle(fontSize: 12)),
                          backgroundColor: AppColors.primary.withAlpha(20),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                          visualDensity: VisualDensity.compact,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              const Text(
                'Daftar dapat berubah; lihat polije.ac.id untuk data terbaru.',
                style: TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
        ),

        // 3. Informasi Program Studi mahasiswa
        _title(Icons.computer, 'Program Studi Saya'),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _info(Icons.apartment, 'Jurusan', PolijeData.myMajor),
              _info(Icons.school, 'Program Studi', PolijeData.myProdi),
              const Divider(),
              Text(PolijeData.myProdiDesc,
                  style: const TextStyle(fontSize: 12.5, height: 1.45)),
            ],
          ),
        ),

        // 4. Fasilitas & Kegiatan
        _title(Icons.emoji_events, 'Fasilitas & Kegiatan Kampus'),
        ...facilities.map(
          (f) => SectionCard(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withAlpha(25),
                  child: Icon(f.icon, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(f.desc,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Text(
            'Sumber: polije.ac.id (Sejarah), PDDikti, dan laman resmi Polije.',
            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}