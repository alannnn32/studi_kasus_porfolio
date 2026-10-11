import 'package:flutter/material.dart';

import '../controllers/portfolio_controller.dart';
import '../data/portfolio_data.dart';
import '../models/project.dart';
import '../theme/app_colors.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/page_scroll.dart';
import '../widgets/project_pager.dart';
import '../widgets/section_card.dart';
import 'project_form_page.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  static const _all = 'Semua';
  String _category = _all;
  String _tech = _all;

  List<Project> _filter(List<Project> all) {
    return all.where((p) {
      final okCat = _category == _all || p.category == _category;
      final okTech = _tech == _all ||
          p.tech.toLowerCase().contains(_tech.toLowerCase());
      return okCat && okTech;
    }).toList();
  }

  Future<void> _delete(Project p) async {
    final ok = await confirmDialog(
      context,
      title: 'Hapus Portofolio',
      message: 'Yakin ingin menghapus "${p.name}"?',
    );
    if (!ok) return;
    await PortfolioController.instance.remove(p.id!);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Portofolio berhasil dihapus')),
    );
  }

  Widget _dropdown(String label, String value, List<String> options,
      ValueChanged<String> onChanged) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          DropdownButton<String>(
            isExpanded: true,
            value: value,
            items: [_all, ...options]
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (v) => onChanged(v!),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: PortfolioController.instance,
      builder: (context, _) {
        final all = PortfolioController.instance.items;
        final shown = _filter(all);
        return PageScroll(
          children: [
            const SizedBox(height: 8),
            SectionCard(
              child: Row(
                children: [
                  _dropdown('Kategori', _category, categories,
                      (v) => setState(() => _category = v)),
                  const SizedBox(width: 16),
                  _dropdown('Teknologi', _tech, technologies,
                      (v) => setState(() => _tech = v)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  const Icon(Icons.work, color: AppColors.primary, size: 22),
                  const SizedBox(width: 8),
                  const Text('My Projects',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text('${shown.length} karya',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
            ),
            const SizedBox(height: 6),
            ProjectPager(
              projects: shown,
              onEdit: (p) => openProjectForm(context, project: p),
              onDelete: _delete,
            ),
            const SizedBox(height: 70), // ruang untuk tombol tambah
          ],
        );
      },
    );
  }
}