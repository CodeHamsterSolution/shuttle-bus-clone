import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmu_shuttle_driver/features/routes/models/station_model.dart';

class RouteModel {
  final int id;
  final String routeName;
  final int totalStations;
  final List<StationModel> stations;
  final List<LatLng> routeLine;

  RouteModel({
    required this.id,
    required this.routeName,
    required this.totalStations,
    required this.stations,
    required this.routeLine,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'] ?? 0,
      routeName: json['name'] ?? '',
      totalStations: json['totalStations'] ?? 0,
      stations:
          (json['stations'] as List<dynamic>?)
              ?.map<StationModel>((station) => StationModel.fromJson(station))
              .toList() ??
          [],
      routeLine:
          (json['routeLine'] as List<dynamic>?)
              ?.map<LatLng>(
                (point) => LatLng(point['latitude'], point['longitude']),
              )
              .toList() ??
          [],
    );
  }
}
