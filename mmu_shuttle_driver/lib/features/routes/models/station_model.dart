class StationModel {
  final String name;
  final double longitude;
  final double latitude;

  StationModel({
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      name: json['name'] ?? '',
      longitude: json['location']['longitude'] ?? 0,
      latitude: json['location']['latitude'] ?? 0,
    );
  }
}
