import 'package:flutter/material.dart';

class ProfileData {
  static const String photo = 'assets/tepe.jpeg';
  static const String name = 'Ahmad Maulana';
  static const String nim = 'E4123456';
  static const String campus = 'Politeknik Negeri Jember';
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