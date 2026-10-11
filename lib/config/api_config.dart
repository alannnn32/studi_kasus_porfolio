/// Alamat backend PHP (XAMPP).
///  - Chrome/web di laptop yang sama : http://localhost/portfolio_api
///  - Emulator Android               : http://10.0.2.2/portfolio_api
///  - HP asli (satu WiFi)            : http://<IP-laptop>/portfolio_api
class ApiConfig {
  static const String baseUrl = 'http://localhost/portfolio_api';

  /// path di database (uploads/xxxx.jpg) -> URL gambar.
  static String imageUrl(String path) =>
      '$baseUrl/image.php?f=${path.split('/').last}';
}