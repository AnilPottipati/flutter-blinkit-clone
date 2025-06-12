import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:blinkit_clone/core/app_constants.dart';

class AddressPickerScreen extends StatefulWidget {
  const AddressPickerScreen({super.key});

  @override
  State<AddressPickerScreen> createState() => _AddressPickerScreenState();
}

class _AddressPickerScreenState extends State<AddressPickerScreen> {
  CameraPosition? _initialPosition;
  LatLng? _selectedLatLng;
  String _selectedAddress = 'Move the map to select location';
  GoogleMapController? _mapController;
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _goToCurrentUserLocation();
  }

  Future<void> _goToCurrentUserLocation() async {
    try {
      Position position = await _determinePosition();
      final latLng = LatLng(position.latitude, position.longitude);
      _initialPosition = CameraPosition(target: latLng, zoom: 17);
      _selectedLatLng = latLng;
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition!));
      _reverseGeocode(latLng);
    } catch (e) {
      // Default to India if location cannot be fetched
      _initialPosition = const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 5);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _reverseGeocode(LatLng position) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks.first;
        setState(() {
          _selectedAddress = [
            if (place.name != null && place.name!.isNotEmpty) place.name,
            if (place.subLocality != null && place.subLocality!.isNotEmpty) place.subLocality,
            if (place.locality != null && place.locality!.isNotEmpty) place.locality,
          ].join(', ');
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = 'Could not fetch address';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Address'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _initialPosition!,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: true,
                  onCameraIdle: () {
                    if (_selectedLatLng != null) {
                      _reverseGeocode(_selectedLatLng!);
                    }
                  },
                  onCameraMove: (pos) {
                    _selectedLatLng = pos.target;
                  },
                ),
                // Center marker
                const Center(
                  child: Icon(Icons.location_pin, size: 40, color: Colors.red),
                ),
                // Search Bar
                Positioned(
                  top: 10,
                  left: 15,
                  right: 15,
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8),
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: _searchController,
                      googleAPIKey: googleApiKey,
                      inputDecoration: InputDecoration(
                        hintText: "Search your location",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        prefixIcon: const Icon(Icons.search),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      debounceTime: 400,
                      countries: const ["in"], // India
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        final lat = double.parse(prediction.lat ?? '0');
                        final lng = double.parse(prediction.lng ?? '0');
                        final latLng = LatLng(lat, lng);
                        _mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: latLng, zoom: 17),
                          ),
                        );
                      },
                      itemClick: (Prediction prediction) {
                        _searchController.text = prediction.description ?? "";
                        _searchController.selection = TextSelection.fromPosition(
                          TextPosition(offset: prediction.description?.length ?? 0),
                        );
                        FocusScope.of(context).unfocus(); // Hide keyboard
                      },
                    ),
                  ),
                ),
                // Address display
                Positioned(
                  bottom: 120,
                  left: 20,
                  right: 20,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        _selectedAddress,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                // Confirm button
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_selectedLatLng != null) {
                        Get.back(result: {
                          'latlng': _selectedLatLng,
                          'address': _selectedAddress,
                        });
                      }
                    },
                    child: const Text('Confirm Location'),
                  ),
                ),
              ],
            ),
    );
  }
}
