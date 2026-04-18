// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmu_shuttle_driver/features/routes/providers/route_provider.dart';
import 'package:provider/provider.dart';

class GoogleMapWidget extends StatelessWidget {
  GoogleMapController? _mapController;

  GoogleMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteProvider>(
      builder: (context, routeProvider, child) {
        final stationPoints = routeProvider.stationPoints;
        final routeLine = routeProvider.routeLine;
        final initialCameraPosition = routeProvider.initialCameraPosition;

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialCameraPosition,
            zoom: 14.0,
          ),
          onMapCreated: (controller) {
            _mapController = controller;
            if (stationPoints.isNotEmpty) {
              Future.delayed(const Duration(milliseconds: 500), () {
                _mapController?.animateCamera(CameraUpdate.zoomIn());
              });
            }
          },
          markers: stationPoints,
          polylines: routeLine,
        );
      },
    );
  }
}
