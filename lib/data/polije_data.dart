import 'package:flutter/material.dart';

/// Sumber: polije.ac.id (halaman Sejarah), PDDikti, dan laman resmi Polije.
/// Teks yang tampil ada di l10n/app_strings.dart (dua bahasa).
class PolijeData {
  static const String website = 'www.polije.ac.id';
}

class Department {
  final String nameKey; // kunci terjemahan nama jurusan
  final IconData icon;

  /// Nama program studi (nama resmi, tidak diterjemahkan).
  /// Diawali '@' = kunci terjemahan.
  final List<String> prodi;
  const Department(this.nameKey, this.icon, this.prodi);
}

const List<Department> departments = [
  Department('d1', Icons.grass, [
    'Produksi Tanaman Hortikultura',
    'Produksi Tanaman Perkebunan',
    'Teknik Produksi Benih',
  ]),
  Department('d2', Icons.precision_manufacturing, [
    'Keteknikan Pertanian',
    'Teknologi Industri Pangan',
  ]),
  Department('d3', Icons.pets, ['Produksi Ternak']),
  Department('d4', Icons.trending_up, [
    'Manajemen Agribisnis',
    'Manajemen Agroindustri',
    'Akuntansi Sektor Publik',
  ]),
  Department('d5', Icons.computer, [
    'Manajemen Informatika',
    'Teknik Komputer',
    'Teknik Informatika',
  ]),
  Department('d6', Icons.translate, ['Bahasa Inggris']),
  Department('d7', Icons.health_and_safety, ['Gizi Klinik', 'Rekam Medik']),
  Department('d8', Icons.engineering, ['@pl_see_site']),
];

class Facility {
  final IconData icon;
  final String titleKey;
  final String descKey;
  const Facility(this.icon, this.titleKey, this.descKey);
}

const List<Facility> facilities = [
  Facility(Icons.factory, 'fac1_t', 'fac1_d'),
  Facility(Icons.work_history, 'fac2_t', 'fac2_d'),
  Facility(Icons.science, 'fac3_t', 'fac3_d'),
  Facility(Icons.location_city, 'fac4_t', 'fac4_d'),
  Facility(Icons.handshake, 'fac5_t', 'fac5_d'),
];