import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blinkit_clone/data/model/location_point.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:flutter/services.dart' show rootBundle;
import 'package:blinkit_clone/core/app_constants.dart';
import 'package:blinkit_clone/view/screens/maps/search_screen.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  final Completer<GoogleMapController> googleMapCompleter = Completer();

  final PolylinePoints polylinePoints = PolylinePoints();
  final polyPoints = <LatLng>[].obs;
  final polylines = <Polyline>{}.obs;
  final markers = <Marker>{}.obs;

  // Holds the fixed start and end points for the route
  final sourceLocation = Rxn<LatLng>();
  final destinationLocation = Rxn<LatLng>();
  
  // Track if using current location as source
  final isUsingCurrentLocation = true.obs;
  final selectedSourceName = 'Current Location'.obs;
  final currentAddress = 'Getting address...'.obs;

  // Holds the user's live location for the bike icon
  final liveUserPosition = Rxn<LatLng>();

  // Lists to hold test locations for search
  final sourceTestLocations = <LocationPoint>[].obs;
  final destinationTestLocations = <LocationPoint>[].obs;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor bikeIcon = BitmapDescriptor.defaultMarker;

  Timer? animationTimer;
  StreamSubscription<Position>? positionStream;
  final currentPolylineIndex = 0.obs;
  final isRouteLoaded = false.obs;
  final iconsLoaded = false.obs;

  final totalDistanceInMeters = 0.0.obs;
  final liveRemainingDistanceInMeters = 0.0.obs;
  final estimatedArrivalTimeString = ''.obs;
  static const double averageSpeedKmph = 20.0;

  @override
  void onInit() {
    super.onInit();
    initCurrentLocation();
    loadMapAssets();
    _loadTestLocations();
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];
        final name = place.name ?? '';
        final locality = place.locality ?? '';
        final subLocality = place.subLocality ?? '';
        
        String address = '';
        if (name.isNotEmpty) address += name;
        if (subLocality.isNotEmpty) {
          if(address.isNotEmpty && !address.contains(subLocality)) address += ", $subLocality";
          else if(address.isEmpty) address += subLocality;
        }
        if (locality.isNotEmpty) {
          if(address.isNotEmpty && !address.contains(locality)) address += ", $locality";
          else if(address.isEmpty) address += locality;
        }

        currentAddress.value = address.isNotEmpty ? address : "Unnamed Location";
      } else {
        currentAddress.value = "Address not found";
      }
    } catch (e) {
      debugPrint("Error getting address: $e");
      currentAddress.value = "Could not get address";
    }
  }

  // Toggle between current location and custom source
  void toggleSourceLocation(LatLng? customSource, String? sourceName) {
    if (customSource == null) {
      // Switch to current location
      isUsingCurrentLocation.value = true;
      selectedSourceName.value = 'Current Location';
      sourceLocation.value = liveUserPosition.value;
      if (liveUserPosition.value != null) {
        _getAddressFromLatLng(liveUserPosition.value!);
      }
    } else {
      // Switch to custom source
      isUsingCurrentLocation.value = false;
      selectedSourceName.value = sourceName ?? 'Custom Location';
      sourceLocation.value = customSource;
      _getAddressFromLatLng(customSource);
    }
    updateMarkers();
  }

  Future<void> initCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        debugPrint("Location permission denied");
        return;
      }
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final userLatLng = LatLng(position.latitude, position.longitude);
      await _getAddressFromLatLng(userLatLng);

      // Set both the initial source and the live position
      sourceLocation.value = userLatLng;
      liveUserPosition.value = userLatLng;

      // Animate camera to user's location on startup
      final GoogleMapController controller = await googleMapCompleter.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: userLatLng, zoom: 15),
        ),
      );

      updateMarkers();

      // Listen for location changes and update the live position
      positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position pos) {
        liveUserPosition.value = LatLng(pos.latitude, pos.longitude);
        // If using current location, update address and source if no route is active
        if (isUsingCurrentLocation.value) {
          _getAddressFromLatLng(liveUserPosition.value!);
          if (!isRouteLoaded.value) {
            sourceLocation.value = liveUserPosition.value;
          }
        }
        updateMarkers();
      });
    } catch (e) {
      debugPrint("Error getting current location: $e");
    }
  }

  Future<void> loadMapAssets() async {
    await setCustomMarkerIcons();
    iconsLoaded.value = true;
    updateMarkers();
  }

  Future<void> setCustomMarkerIcons() async {
    try {
      final List<BitmapDescriptor> icons = await Future.wait([
        BitmapDescriptor.asset(
          const ImageConfiguration(size: Size(48, 48)),
          'assets/images/source_icon_new.png',
        ),
        BitmapDescriptor.asset(
          const ImageConfiguration(size: Size(48, 48)),
          'assets/images/destination_icon_new.png',
        ),
        BitmapDescriptor.asset(
          const ImageConfiguration(size: Size(48, 48)),
          'assets/images/bike_icon.png',
        ),
      ]);
      sourceIcon = icons[0];
      destinationIcon = icons[1];
      bikeIcon = icons[2];
      iconsLoaded.value = true;
      updateMarkers();
    } catch (e) {
      debugPrint("Error loading custom marker icons: $e");
      iconsLoaded.value = true;
      updateMarkers();
    }
  }

  void updateMarkers() {
    if (!iconsLoaded.value) return;
    final Set<Marker> newMarkers = {};

    // Add the static source marker
    if (sourceLocation.value != null) {
      newMarkers.add(
        Marker(
          markerId: const MarkerId("source"),
          position: sourceLocation.value!,
          icon: sourceIcon,
          infoWindow: const InfoWindow(title: "Starting Point"),
        ),
      );
    }

    // Add the static destination marker
    if (destinationLocation.value != null) {
      newMarkers.add(
        Marker(
          markerId: const MarkerId("destination"),
          position: destinationLocation.value!,
          icon: destinationIcon,
          infoWindow: const InfoWindow(title: "Destination"),
        ),
      );
    }

    // Add the moving bike marker based on live position
    if (liveUserPosition.value != null) {
      newMarkers.add(
        Marker(
          markerId: const MarkerId("bike"),
          position: liveUserPosition.value!,
          icon: bikeIcon,
          infoWindow: const InfoWindow(title: "You are here"),
        ),
      );
    }
    markers.value = newMarkers;
  }

  void updateEta() {
    if (liveRemainingDistanceInMeters.value <= 10) {
      estimatedArrivalTimeString.value = "Arrived";
      liveRemainingDistanceInMeters.value = 0;
    } else {
      double remainingDistanceKm = liveRemainingDistanceInMeters.value / 1000.0;
      double timeHours = remainingDistanceKm / averageSpeedKmph;
      double timeMinutes = timeHours * 60;
      if (timeMinutes < 1) {
        estimatedArrivalTimeString.value = "Arriving shortly";
      } else {
        estimatedArrivalTimeString.value = "${timeMinutes.round()} min";
      }
    }
  }

  Future<void> _loadTestLocations() async {
    try {
      // Load sources into memory for search
      String sourceData = await rootBundle.loadString(
        'assets/maps/sources.json',
      );
      final List<dynamic> sourceJson = json.decode(sourceData);
      sourceTestLocations.value =
          sourceJson.map((item) => LocationPoint.fromJson(item)).toList();

      // Load destinations into memory for search
      String destData = await rootBundle.loadString(
        'assets/maps/destinations.json',
      );
      final List<dynamic> destJson = json.decode(destData);
      destinationTestLocations.value =
          destJson.map((item) => LocationPoint.fromJson(item)).toList();
    } catch (e) {
      debugPrint("Error loading test locations: $e");
    }
  }

  Future<void> fetchPolylinePoints() async {
    if (sourceLocation.value == null || destinationLocation.value == null) {
      debugPrint("Source or Destination is null, cannot fetch polylines.");
      isRouteLoaded.value = false;
      polylines.clear();
      liveRemainingDistanceInMeters.value = 0;
      estimatedArrivalTimeString.value = "";
      return;
    }
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleApiKey,
        request: PolylineRequest(
          origin: PointLatLng(
            sourceLocation.value!.latitude,
            sourceLocation.value!.longitude,
          ),
          destination: PointLatLng(
            destinationLocation.value!.latitude,
            destinationLocation.value!.longitude,
          ),
          mode: TravelMode.driving,
        ),
      );
      if (result.points.isNotEmpty) {
        polyPoints.value =
            result.points
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList();
        polylines.clear();
        polylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: polyPoints,
            color: Colors.blue,
            width: 5,
          ),
        );
        isRouteLoaded.value = true;
        totalDistanceInMeters.value = Geolocator.distanceBetween(
          polyPoints.first.latitude,
          polyPoints.first.longitude,
          polyPoints.last.latitude,
          polyPoints.last.longitude,
        );
        liveRemainingDistanceInMeters.value = totalDistanceInMeters.value;
        currentPolylineIndex.value = 0;
        startAnimation();
        updateEta();
      } else {
        debugPrint(result.errorMessage);
        isRouteLoaded.value = false;
      }
    } catch (e) {
      debugPrint("Error fetching polylines: $e");
      isRouteLoaded.value = false;
    }
  }

  void startAnimation() {
    positionStream?.pause(); // Pause live GPS updates during animation
    animationTimer?.cancel();
    animationTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (currentPolylineIndex.value < polyPoints.length - 1) {
        currentPolylineIndex.value++;
        liveUserPosition.value = polyPoints[currentPolylineIndex.value];

        liveRemainingDistanceInMeters.value = Geolocator.distanceBetween(
          liveUserPosition.value!.latitude,
          liveUserPosition.value!.longitude,
          polyPoints.last.latitude,
          polyPoints.last.longitude,
        );

        updateMarkers();
        updateEta();

        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: liveUserPosition.value!, zoom: 17.0),
          ),
        );
      } else {
        timer.cancel();
        liveUserPosition.value = destinationLocation.value;
        liveRemainingDistanceInMeters.value = 0;
        updateEta();
        updateMarkers();
        positionStream?.resume();
        debugPrint("Animation completed.");
      }
    });
  }

  Future<void> navigateToSearch() async {
    if (liveUserPosition.value == null) {
      Get.snackbar('Error', 'Current location not available.');
      return;
    }
    final result = await Get.to(
      () => SearchScreen(currentLocation: liveUserPosition.value!),
    );
    if (result != null && result is Map) {
      sourceLocation.value = result['source'];
      destinationLocation.value = result['destination'];
      fetchPolylinePoints();
      updateMarkers();
    }
  }

  void resetRoute() {
    destinationLocation.value = null;
    isRouteLoaded.value = false;
    polylines.clear();
    polyPoints.clear();
    currentPolylineIndex.value = 0;
  }

  // Reset the entire controller state for logout
  void resetController() {
    animationTimer?.cancel();
    positionStream?.cancel();

    polylines.clear();
    markers.clear();
    polyPoints.clear();

    sourceLocation.value = null;
    destinationLocation.value = null;
    liveUserPosition.value = null;
    isRouteLoaded.value = false;
    currentPolylineIndex.value = 0;

    totalDistanceInMeters.value = 0.0;
    liveRemainingDistanceInMeters.value = 0.0;
    estimatedArrivalTimeString.value = '';

    isUsingCurrentLocation.value = true;
    selectedSourceName.value = 'Current Location';
    currentAddress.value = 'Getting address...';

    // Re-initialize location for the next session
    initCurrentLocation();

    update();
  }

  @override
  void onClose() {
    animationTimer?.cancel();
    positionStream?.cancel();
    mapController?.dispose();
    super.onClose();
  }
}
