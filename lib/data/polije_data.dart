import 'package:flutter/material.dart';

/// Sumber: polije.ac.id (halaman Sejarah), PDDikti, dan laman resmi Polije.
/// Jumlah jurusan/prodi dapat berubah; cek polije.ac.id untuk data terbaru.
class PolijeData {
  static const String name = 'Politeknik Negeri Jember (Polije)';
  static const String address = 'Jl. Mastrip PO BOX 164, Jember, Jawa Timur';
  static const String type = 'Perguruan Tinggi Negeri (Vokasi)';
  static const String founded =
      '29 Oktober 1988 (Politeknik Pertanian Universitas Jember)';
  static const String renamed =
      '5 November 2002 menjadi Politeknik Negeri Jember';
  static const String website = 'www.polije.ac.id';
  static const String summary =
      'Politeknik Negeri Jember adalah perguruan tinggi vokasi di Kabupaten '
      'Jember, Jawa Timur. Berawal dari program pemerintah pengembangan '
      'politeknik pertanian pada 1980, kampus ini resmi dibuka pada 1988 '
      'sebagai Politeknik Pertanian Universitas Jember, lalu menjadi '
      'Politeknik Negeri Jember pada 2002.';

  static const List<String> vocationalPoints = [
    'Fokus pada keahlian dan keterampilan siap kerja sesuai kebutuhan industri.',
    'Porsi pembelajaran praktik lebih besar dibanding teori.',
    'Jenjang Diploma (D3) dan Sarjana Terapan (D4).',
    'Praktik Kerja Lapang (PKL)/magang di dunia usaha dan industri.',
    'Lulusan dipersiapkan bekerja maupun berwirausaha.',
  ];

  static const String myMajor = 'Jurusan Teknologi Informasi';
  static const String myProdi = 'Program Studi Teknik Informatika';
  static const String myProdiDesc =
      'Mempelajari pemrograman, basis data, pengembangan aplikasi web dan '
      'mobile, serta rekayasa perangkat lunak dengan pendekatan praktik. '
      'Lulusan disiapkan sebagai developer, analis sistem, maupun wirausaha '
      'di bidang teknologi informasi.';
}

class Department {
  final String name;
  final IconData icon;
  final List<String> prodi;
  const Department(this.name, this.icon, this.prodi);
}

const List<Department> departments = [
  Department('Produksi Pertanian', Icons.grass, [
    'Produksi Tanaman Hortikultura',
    'Produksi Tanaman Perkebunan',
    'Teknik Produksi Benih',
  ]),
  Department('Teknologi Pertanian', Icons.precision_manufacturing, [
    'Keteknikan Pertanian',
    'Teknologi Industri Pangan',
  ]),
  Department('Peternakan', Icons.pets, ['Produksi Ternak']),
  Department('Manajemen Agribisnis', Icons.trending_up, [
    'Manajemen Agribisnis',
    'Manajemen Agroindustri',
    'Akuntansi Sektor Publik',
  ]),
  Department('Teknologi Informasi', Icons.computer, [
    'Manajemen Informatika',
    'Teknik Komputer',
    'Teknik Informatika',
  ]),
  Department('Bahasa, Komunikasi & Pariwisata', Icons.translate, [
    'Bahasa Inggris',
  ]),
  Department('Kesehatan', Icons.health_and_safety, [
    'Gizi Klinik',
    'Rekam Medik',
  ]),
  Department('Teknik', Icons.engineering, [
    'Lihat daftar lengkap di polije.ac.id',
  ]),
];

class Facility {
  final IconData icon;
  final String title;
  final String desc;
  const Facility(this.icon, this.title, this.desc);
}

const List<Facility> facilities = [
  Facility(Icons.factory, 'Teaching Factory (Tefa)',
      'Pembelajaran berbasis produksi yang menghubungkan kampus dengan industri.'),
  Facility(Icons.work_history, 'Praktik Kerja Lapang',
      'Mahasiswa menjalani PKL/magang di instansi dan perusahaan mitra.'),
  Facility(Icons.science, 'Laboratorium & Lahan Praktik',
      'Fasilitas praktik sesuai bidang: pertanian, peternakan, teknologi, kesehatan.'),
  Facility(Icons.location_city, 'Kampus PSDKU',
      'Program studi di luar kampus utama (mis. PSDKU Bondowoso).'),
  Facility(Icons.handshake, 'Kerja Sama Industri',
      'Kemitraan dengan dunia usaha dan instansi untuk magang dan penyerapan lulusan.'),
];