import 'package:flutter/material.dart';

import '../models/project.dart';
import '../theme/app_colors.dart';
import 'project_image.dart';

/// Kartu satu karya. Tombol Edit/Hapus hanya tampil bila callback diberikan.
class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: Colors.white,
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(project.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(project.category,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _meta(Icons.calendar_today_outlined,
                        'Tahun : ${project.year}'),
                    const SizedBox(height: 4),
                    _meta(Icons.layers_outlined,
                        'Teknologi : ${project.tech}'),
                    const SizedBox(height: 8),
                    Text(project.description,
                        style: const TextStyle(fontSize: 12.5, height: 1.4)),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => _showDetail(context),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Lihat Detail'),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ),
                  if (onEdit != null)
                    IconButton(
                      tooltip: 'Edit',
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, color: AppColors.primary),
                    ),
                  if (onDelete != null)
                    IconButton(
                      tooltip: 'Hapus',
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() => ProjectImage(path: project.image, height: 160);

  Widget _meta(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5))),
      ],
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('${project.category}  •  ${project.year}',
                  style: const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 8),
              Text('Teknologi: ${project.tech}',
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(project.description, style: const TextStyle(height: 1.5)),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}