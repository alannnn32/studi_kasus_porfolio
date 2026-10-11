import 'package:flutter/material.dart';

import '../controllers/portfolio_controller.dart';
import '../data/portfolio_data.dart';
import '../l10n/app_strings.dart';
import '../models/project.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/load_status.dart';
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
  // Nilai internal "semua" (tidak ditampilkan; label diterjemahkan).
  static const _all = '*';
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
      title: context.tr('delete_title'),
      message: context.tr('delete_confirm', {'name': p.name}),
    );
    if (!ok || !mounted) return;
    try {
      await PortfolioController.instance.remove(p.id!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('deleted_ok'))),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(context.tr('delete_failed', {'msg': e.message}))),
      );
    }
  }

  Widget _dropdown(String label, String value, List<String> options,
      ValueChanged<String> onChanged,
      {String Function(String)? labelOf}) {
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
                .map((o) => DropdownMenuItem(
                      value: o,
                      child: Text(
                        o == _all
                            ? context.tr('all')
                            : (labelOf?.call(o) ?? o),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
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
                  _dropdown(context.tr('filter_category'), _category,
                      categories, (v) => setState(() => _category = v),
                      labelOf: context.catName),
                  const SizedBox(width: 16),
                  _dropdown(context.tr('filter_tech'), _tech, technologies,
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
                  Text(context.tr('my_projects'),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(context.tr('works_count', {'n': '${shown.length}'}),
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
            ),
            const SizedBox(height: 6),
            LoadStatus(
              child: ProjectPager(
                projects: shown,
                onEdit: (p) => openProjectForm(context, project: p),
                onDelete: _delete,
              ),
            ),
            const SizedBox(height: 70), // ruang untuk tombol tambah
          ],
        );
      },
    );
  }
}