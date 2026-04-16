class AnnouncementModel {
  final int id;
  final String title;
  final String description;
  final String? fileName;
  bool isPinned;
  final DateTime createdAt;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileName,
    required this.isPinned,
    required this.createdAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      fileName: json['fileName'],
      isPinned: json['isPinned'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
