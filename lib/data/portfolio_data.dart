import 'package:flutter/material.dart';

import '../models/project.dart';

class ProfileData {
  static const String photo = 'assets/tepe.jpeg';
  static const String name = 'Ahmad Maulana';
  static const String nim = 'E4123456';
  static const String prodi = 'Teknik Informatika';
  static const String campus = 'Politeknik Negeri Jember';
  static const String tagline = 'Terus belajar, berkarya,\ndan memberi manfaat!';
  static const String about =
      'Saya adalah mahasiswa Teknik Informatika yang memiliki ketertarikan '
      'di bidang pengembangan aplikasi, desain UI/UX, serta teknologi web '
      'dan mobile. Saya senang belajar hal baru, mengeksplorasi teknologi, '
      'dan selalu berusaha untuk menghasilkan karya yang bermanfaat.';
}

/// Daftar teknologi untuk Dropdown (profil & filter portofolio).
const List<String> technologies = [
  'Flutter',
  'Laravel',
  'React',
  'Python',
  'Java',
  'PHP',
];

/// Daftar kategori karya untuk Dropdown (form & filter).
const List<String> categories = [
  'Website',
  'Mobile App',
  'UI/UX',
  'Java',
  'Sistem Informasi',
];

/// Pilihan gambar (aset bawaan) pada form tambah/ubah karya.
const Map<String, String> imageOptions = {
  'Tanpa gambar': '',
  'Inventaris (image.png)': 'assets/image.png',
  'Desain Figma (figma.png)': 'assets/figma.png',
  'Katalog (catalog.jpeg)': 'assets/catalog.jpeg',
};

const Map<String, IconData> techIcons = {
  'Flutter': Icons.flutter_dash,
  'Laravel': Icons.layers,
  'React': Icons.hub,
  'Python': Icons.terminal,
  'Java': Icons.coffee,
  'PHP': Icons.code,
  'UI/UX': Icons.draw,
  'Web Development': Icons.language,
};

const List<String> skills = [
  'Flutter',
  'Laravel',
  'React',
  'Python',
  'UI/UX',
  'Web Development',
];

class ContactItem {
  final IconData icon;
  final Color color;
  final String text;
  const ContactItem(this.icon, this.color, this.text);
}

const List<ContactItem> contacts = [
  ContactItem(Icons.email, Color(0xFF8B5CF6), 'ahmadmaulana@gmail.com'),
  ContactItem(Icons.phone, Color(0xFF22C55E), '+62 812 3456 7890'),
  ContactItem(Icons.code, Color(0xFF111827), 'github.com/ahmadmaulana'),
  ContactItem(Icons.work, Color(0xFF0A66C2), 'linkedin.com/in/ahmadmaulana'),
];

/// Data awal yang dimasukkan ke database saat pertama kali dibuat.
/// Karya ke-4 dan ke-5 adalah contoh: silakan ubah lewat fitur Edit.
const List<Project> seedProjects = [
  Project(
    name: 'Sistem Inventaris MbahMeth',
    category: 'Website',
    year: '2025',
    tech: 'HTML, CSS, JavaScript, PHP',
    description:
        'Website untuk mencatat data produk dan stok barang secara terstruktur '
        'sehingga pengelolaan inventaris toko menjadi lebih mudah dan akurat.',
    image: 'assets/image.png',
  ),
  Project(
    name: 'Desain UI/UX Toko Pertanian',
    category: 'UI/UX',
    year: '2026',
    tech: 'Figma',
    description:
        'Rancangan antarmuka dan pengalaman pengguna aplikasi toko pertanian '
        'MbahMeth, mulai dari wireframe hingga prototipe interaktif.',
    image: 'assets/figma.png',
  ),
  Project(
    name: 'Aplikasi AgriCollect MbahMeth',
    category: 'Mobile App',
    year: '2026',
    tech: 'Flutter, Dart, PHP',
    description:
        'Aplikasi e-commerce untuk mempermudah pembeli melakukan booking '
        'pembelian produk pertanian dari rumah.',
    image: 'assets/catalog.jpeg',
  ),
  Project(
    name: 'POLIJE Student Portfolio',
    category: 'Mobile App',
    year: '2026',
    tech: 'Flutter, Dart, SQLite',
    description:
        'Aplikasi portofolio mahasiswa dengan fitur CRUD, database lokal '
        'SQLite, dan halaman informasi Politeknik Negeri Jember.',
  ),
  Project(
    name: 'Aplikasi Kasir Sederhana (contoh)',
    category: 'Java',
    year: '2025',
    tech: 'Java',
    description:
        'Contoh karya berbasis Java. Ubah judul, tahun, dan deskripsi ini '
        'sesuai karya aslimu lewat tombol Edit.',
  ),
];