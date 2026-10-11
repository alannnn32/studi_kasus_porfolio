import 'package:flutter/material.dart';

import '../config/api_config.dart';
import '../theme/app_colors.dart';

/// Menampilkan gambar karya: aset bawaan, gambar upload dari server,
/// atau placeholder gradient bila kosong / gagal dimuat.
class ProjectImage extends StatelessWidget {
  final String path;
  final double height;

  const ProjectImage({super.key, required this.path, this.height = 160});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.headerGradient),
      child: const Icon(Icons.image_outlined, color: Colors.white54, size: 48),
    );
    if (path.isEmpty) return placeholder;

    if (path.startsWith('uploads/')) {
      return Image.network(
        ApiConfig.imageUrl(path),
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : SizedBox(
                height: height,
                child: const Center(child: CircularProgressIndicator()),
              ),
      );
    }
    return Image.asset(
      path,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}