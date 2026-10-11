class Project {
  final int? id;
  final String name;
  final String category;
  final String year;
  final String tech;
  final String description;

  /// '' = tanpa gambar, 'assets/...' = gambar bawaan app,
  /// 'uploads/...' = gambar yang diunggah ke server.
  final String image;

  const Project({
    this.id,
    required this.name,
    required this.category,
    required this.year,
    required this.tech,
    required this.description,
    this.image = '',
  });

  factory Project.fromJson(Map<String, dynamic> m) => Project(
        id: int.tryParse('${m['id']}'),
        name: '${m['name']}',
        category: '${m['category']}',
        year: '${m['year']}',
        tech: '${m['tech']}',
        description: '${m['description']}',
        image: '${m['image'] ?? ''}',
      );
}