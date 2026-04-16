class LiveRideModel {
  final int routeId;
  final double latitude;
  final double longitude;

  LiveRideModel({
    required this.routeId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'routeId': routeId,
      'location': {'latitude': latitude, 'longitude': longitude},
    };
  }
}
