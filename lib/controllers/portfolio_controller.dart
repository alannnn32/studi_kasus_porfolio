import 'package:flutter/foundation.dart';

import '../models/project.dart';
import '../services/api_service.dart';

/// Menyimpan daftar portofolio di memori & menyinkronkannya dengan server.
class PortfolioController extends ChangeNotifier {
  PortfolioController._();
  static final PortfolioController instance = PortfolioController._();

  List<Project> _items = [];
  List<Project> get items => List.unmodifiable(_items);

  bool loading = false;
  bool loaded = false; // sudah pernah berhasil memuat data
  String? error;

  /// Muat awal / coba lagi. Error disimpan di [error] (tidak dilempar).
  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      _items = await ApiService.getProjects();
      loaded = true;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    loading = false;
    notifyListeners();
  }

  /// Ambil ulang data setelah perubahan. Error dilempar ke pemanggil.
  Future<void> _refresh() async {
    _items = await ApiService.getProjects();
    loaded = true;
    error = null;
    notifyListeners();
  }

  Future<void> add(Project p, {UploadImage? image}) async {
    await ApiService.create(p, image: image);
    await _refresh();
  }

  Future<void> update(Project p,
      {UploadImage? image, bool removeImage = false}) async {
    await ApiService.update(p, image: image, removeImage: removeImage);
    await _refresh();
  }

  Future<void> remove(int id) async {
    await ApiService.delete(id);
    await _refresh();
  }

  Future<void> resetToSeed() async {
    await ApiService.reset();
    await _refresh();
  }

  Future<void> removeAll() async {
    await ApiService.deleteAll();
    await _refresh();
  }
}