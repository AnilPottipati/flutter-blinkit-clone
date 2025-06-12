import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPoint {
  final String name;
  final double latitude;
  final double longitude;

  LocationPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  LatLng toLatLng() => LatLng(latitude, longitude);

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    return LocationPoint(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}

