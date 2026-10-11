import 'package:flutter/material.dart';

import '../models/project.dart';
import '../theme/app_colors.dart';
import 'project_card.dart';
import 'section_card.dart';

/// PageView karya + indikator + tombol Sebelumnya/Berikutnya (PageController).
class ProjectPager extends StatefulWidget {
  final List<Project> projects;
  final void Function(Project)? onEdit;
  final void Function(Project)? onDelete;

  const ProjectPager({
    super.key,
    required this.projects,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<ProjectPager> createState() => _ProjectPagerState();
}

class _ProjectPagerState extends State<ProjectPager> {
  final PageController _controller = PageController();
  int _current = 0;

  @override
  void didUpdateWidget(covariant ProjectPager old) {
    super.didUpdateWidget(old);
    final a = old.projects.map((p) => p.id).toList();
    final b = widget.projects.map((p) => p.id).toList();
    // Daftar berubah (tambah/hapus/filter): kembali ke halaman pertama.
    if (a.length != b.length || (b.isNotEmpty && a.first != b.first)) {
      _current = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _controller.hasClients) _controller.jumpToPage(0);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(bool next) {
    const d = Duration(milliseconds: 300);
    const c = Curves.easeInOut;
    if (next) {
      _controller.nextPage(duration: d, curve: c);
    } else {
      _controller.previousPage(duration: d, curve: c);
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.projects;
    if (list.isEmpty) {
      return const SectionCard(
        child: Column(
          children: [
            Icon(Icons.folder_open, size: 44, color: AppColors.textMuted),
            SizedBox(height: 8),
            Text('Belum ada karya',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Tambahkan karya baru atau ubah filter.',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ],
        ),
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 450,
          child: PageView.builder(
            controller: _controller,
            itemCount: list.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) {
              final p = list[i];
              return ProjectCard(
                project: p,
                onEdit: widget.onEdit == null ? null : () => widget.onEdit!(p),
                onDelete:
                    widget.onDelete == null ? null : () => widget.onDelete!(p),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(list.length, (i) {
            final active = i == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
              width: active ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: _current > 0 ? () => _go(false) : null,
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text('Sebelumnya'),
              ),
              FilledButton(
                onPressed: _current < list.length - 1 ? () => _go(true) : null,
                style:
                    FilledButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Berikutnya'),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}