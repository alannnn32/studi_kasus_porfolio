import 'package:flutter/material.dart';

/// Halaman scroll yang responsif: konten dibatasi lebar maksimum 640
/// dan diposisikan di tengah pada layar lebar (tablet/landscape).
class PageScroll extends StatelessWidget {
  final List<Widget> children;
  const PageScroll({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}