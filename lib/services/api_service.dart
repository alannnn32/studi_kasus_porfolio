import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/project.dart';

/// Gambar yang dipilih dari galeri (siap diunggah).
class UploadImage {
  final Uint8List bytes;
  final String filename;
  const UploadImage(this.bytes, this.filename);
}

/// Error dari server / koneksi. [message] aman ditampilkan ke pengguna.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  @override
  String toString() => message;
}

/// Komunikasi dengan backend PHP + MySQL.
class ApiService {
  static const _timeout = Duration(seconds: 15);

  static Uri _u(String file) => Uri.parse('${ApiConfig.baseUrl}/$file');

  static Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on TimeoutException {
      throw ApiException('Server tidak merespons. Periksa XAMPP dan alamat API.');
    } on http.ClientException {
      throw ApiException(
          'Tidak dapat terhubung ke server. Pastikan Apache & MySQL di XAMPP aktif.');
    }
  }

  static Map<String, dynamic> _decode(http.Response res) {
    Map<String, dynamic> body;
    try {
      body = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException('Respons server tidak valid (HTTP ${res.statusCode})');
    }
    if (res.statusCode >= 400 || body['success'] != true) {
      throw ApiException(body['message'] ?? 'Terjadi kesalahan pada server');
    }
    return body;
  }

  static Future<List<Project>> getProjects() => _guard(() async {
        final res = await http.get(_u('list.php')).timeout(_timeout);
        final body = _decode(res);
        return (body['data'] as List)
            .map((e) => Project.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  static Future<void> _post(String file, Map<String, String> fields,
      {UploadImage? image}) {
    return _guard(() async {
      final req = http.MultipartRequest('POST', _u(file))
        ..fields.addAll(fields);
      if (image != null) {
        req.files.add(http.MultipartFile.fromBytes('image', image.bytes,
            filename: image.filename));
      }
      final res = await http.Response.fromStream(await req.send())
          .timeout(const Duration(seconds: 30));
      _decode(res);
    });
  }

  static Map<String, String> _fields(Project p) => {
        'name': p.name,
        'category': p.category,
        'year': p.year,
        'tech': p.tech,
        'description': p.description,
      };

  static Future<void> create(Project p, {UploadImage? image}) =>
      _post('create.php', _fields(p), image: image);

  static Future<void> update(Project p,
          {UploadImage? image, bool removeImage = false}) =>
      _post(
        'update.php',
        {
          ..._fields(p),
          'id': '${p.id}',
          if (removeImage) 'remove_image': '1',
        },
        image: image,
      );

  static Future<void> delete(int id) => _post('delete.php', {'id': '$id'});
  static Future<void> reset() => _post('reset.php', {});
  static Future<void> deleteAll() => _post('delete_all.php', {});
}