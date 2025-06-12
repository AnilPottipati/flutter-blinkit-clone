import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressModel {
  final String title;
  final String address;
  final LatLng latlng;

  AddressModel({
    required this.title,
    required this.address,
    required this.latlng,
  });
}
