import 'package:flutter/material.dart';

import '../controllers/portfolio_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/page_scroll.dart';
import '../widgets/section_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  /// Jalankan aksi ke server, lalu tampilkan hasilnya.
  Future<void> _run(BuildContext context, Future<void> Function() action,
      String okMessage) async {
    String msg = okMessage;
    try {
      await action();
    } catch (e) {
      msg = e.toString().replaceFirst('Exception: ', '');
    }
    if (context.mounted) _snack(context, msg);
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioController.instance;
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Data Portofolio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              ListenableBuilder(
                listenable: c,
                builder: (_, __) => Text(
                  'Total karya tersimpan: ${c.items.length}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.refresh, color: AppColors.primary),
                title: const Text('Muat ulang data'),
                subtitle: const Text('Ambil data terbaru dari server'),
                onTap: () async {
                  await c.load();
                  if (context.mounted) {
                    _snack(context, c.error ?? 'Data berhasil dimuat ulang');
                  }
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.restore, color: AppColors.primary),
                title: const Text('Reset ke data awal'),
                subtitle: const Text('Mengembalikan 5 karya bawaan'),
                onTap: () async {
                  final ok = await confirmDialog(
                    context,
                    title: 'Reset Data',
                    message:
                        'Semua perubahan akan hilang dan data kembali ke bawaan. Lanjutkan?',
                    confirmText: 'Reset',
                  );
                  if (!ok || !context.mounted) return;
                  await _run(context, c.resetToSeed, 'Data berhasil direset');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Hapus semua karya'),
                subtitle: const Text('Mengosongkan tabel portofolio di MySQL'),
                onTap: () async {
                  final ok = await confirmDialog(
                    context,
                    title: 'Hapus Semua',
                    message: 'Semua karya akan dihapus permanen. Lanjutkan?',
                  );
                  if (!ok || !context.mounted) return;
                  await _run(context, c.removeAll,
                      'Semua karya berhasil dihapus');
                },
              ),
            ],
          ),
        ),
        const SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tentang Aplikasi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 8),
              Text('POLIJE Student Portfolio',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Versi 1.1.0',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              SizedBox(height: 6),
              Text(
                'Dibuat dengan Flutter. Data karya disimpan di database MySQL '
                '(XAMPP) melalui API PHP, gambar diunggah dari galeri.',
                style: TextStyle(fontSize: 12.5, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}