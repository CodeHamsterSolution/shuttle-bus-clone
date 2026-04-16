class CreateAnnouncementModel {
  final String title;
  final String description;
  final bool isPinned;

  CreateAnnouncementModel({
    required this.title,
    required this.description,
    required this.isPinned,
  });

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'isPinned': isPinned};
  }
}
