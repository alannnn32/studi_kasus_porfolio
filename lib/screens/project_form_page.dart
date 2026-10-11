import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/portfolio_controller.dart';
import '../data/portfolio_data.dart';
import '../models/project.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/project_image.dart';

/// Buka form tambah (project == null) atau edit karya.
Future<void> openProjectForm(BuildContext context, {Project? project}) async {
  final saved = await Navigator.of(context).push<bool>(
    MaterialPageRoute(builder: (_) => ProjectFormPage(project: project)),
  );
  if (saved == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(project == null
          ? 'Portofolio berhasil ditambahkan'
          : 'Portofolio berhasil diperbarui'),
    ));
  }
}

class ProjectFormPage extends StatefulWidget {
  final Project? project;
  const ProjectFormPage({super.key, this.project});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  late final TextEditingController _name;
  late final TextEditingController _year;
  late final TextEditingController _tech;
  late final TextEditingController _desc;
  late String _category;

  String _existingImage = ''; // gambar yang sudah tersimpan (mode edit)
  UploadImage? _newImage; // gambar baru dari galeri
  bool _removeImage = false;
  bool _saving = false;

  bool get _isEdit => widget.project != null;

  bool get _hasImage =>
      _newImage != null || (!_removeImage && _existingImage.isNotEmpty);

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _name = TextEditingController(text: p?.name ?? '');
    _year = TextEditingController(text: p?.year ?? '${DateTime.now().year}');
    _tech = TextEditingController(text: p?.tech ?? '');
    _desc = TextEditingController(text: p?.description ?? '');
    _category = (p != null && categories.contains(p.category))
        ? p.category
        : categories.first;
    _existingImage = p?.image ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    _year.dispose();
    _tech.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  Future<void> _pickImage() async {
    try {
      final x = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (x == null) return;
      final bytes = await x.readAsBytes();
      if (bytes.length > 5 * 1024 * 1024) {
        _snack('Ukuran gambar maksimal 5 MB');
        return;
      }
      setState(() {
        _newImage = UploadImage(bytes, x.name.isEmpty ? 'image.jpg' : x.name);
        _removeImage = false;
      });
    } catch (_) {
      _snack('Gagal membuka galeri');
    }
  }

  void _clearImage() {
    setState(() {
      _newImage = null;
      _removeImage = true;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final data = Project(
      id: widget.project?.id,
      name: _name.text.trim(),
      category: _category,
      year: _year.text.trim(),
      tech: _tech.text.trim(),
      description: _desc.text.trim(),
    );
    final c = PortfolioController.instance;
    try {
      if (_isEdit) {
        await c.update(data,
            image: _newImage, removeImage: _removeImage && _newImage == null);
      } else {
        await c.add(data, image: _newImage);
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      _snack(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  InputDecoration _dec(String label, IconData icon, {String? hint}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );

  Widget _imagePreview() {
    if (_newImage != null) {
      return Image.memory(_newImage!.bytes,
          height: 160, width: double.infinity, fit: BoxFit.cover);
    }
    return ProjectImage(path: _existingImage, height: 160);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: _isEdit ? 'Edit Portofolio' : 'Tambah Portofolio',
        subtitle: 'Isi data karya dengan lengkap',
        icon: _isEdit ? Icons.edit : Icons.add_circle_outline,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    textInputAction: TextInputAction.next,
                    decoration: _dec('Nama Project', Icons.title),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Nama project wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    value: _category,
                    decoration: _dec('Kategori', Icons.category),
                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => _category = v!),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _year,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: _dec('Tahun Pembuatan', Icons.calendar_today),
                    validator: (v) {
                      final y = int.tryParse((v ?? '').trim());
                      if (y == null) return 'Tahun harus berupa angka';
                      if (y < 2000 || y > DateTime.now().year + 1) {
                        return 'Tahun tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _tech,
                    textInputAction: TextInputAction.next,
                    decoration: _dec('Teknologi', Icons.layers,
                        hint: 'Contoh: Flutter, Dart, PHP'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Teknologi wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _desc,
                    maxLines: 4,
                    decoration: _dec('Deskripsi Singkat', Icons.notes),
                    validator: (v) => (v == null || v.trim().length < 10)
                        ? 'Deskripsi minimal 10 karakter'
                        : null,
                  ),
                  const SizedBox(height: 14),

                  // ---- Gambar dari galeri ----
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Gambar Project',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        if (_hasImage)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _imagePreview(),
                          )
                        else
                          Container(
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text('Belum ada gambar',
                                style: TextStyle(color: AppColors.textMuted)),
                          ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: [
                            OutlinedButton.icon(
                              onPressed: _saving ? null : _pickImage,
                              icon: const Icon(Icons.photo_library),
                              label: Text(_hasImage
                                  ? 'Ganti dari Galeri'
                                  : 'Pilih dari Galeri'),
                            ),
                            if (_hasImage)
                              TextButton.icon(
                                onPressed: _saving ? null : _clearImage,
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                label: const Text('Hapus gambar',
                                    style: TextStyle(color: Colors.red)),
                              ),
                          ],
                        ),
                        const Text('Format JPG/PNG/WEBP/GIF, maks. 5 MB',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed:
                              _saving ? null : () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary),
                          onPressed: _saving ? null : _save,
                          icon: _saving
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.save),
                          label: Text(_isEdit ? 'Simpan Perubahan' : 'Simpan'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}