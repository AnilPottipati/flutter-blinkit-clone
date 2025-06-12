import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:blinkit_clone/core/app_constants.dart';
import 'package:blinkit_clone/data/model/location_point.dart';
import 'package:blinkit_clone/data/repo/map_repo.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:uuid/uuid.dart';

class PlaceDetailsResult {
  final double lat;
  final double lng;
  final String? name;

  PlaceDetailsResult({
    required this.lat,
    required this.lng,
    this.name,
  });
}

class LocationSearchController extends GetxController {
  final MapRepo _mapRepo = MapRepo();
  Timer? _debounce;

  // For source selection
  var sources = <LocationPoint>[].obs;
  var selectedSourceLocation = Rxn<LatLng>();
  var selectedSourceText = 'Tap to select source'.obs;
  late LatLng initialSourceLocation;

  // For destination search
  var searchResults = <Prediction>[].obs;
  var isSearching = false.obs;
  var searchText = ''.obs;
  String? _sessionToken;

  void startNewSearchSession() {
    _sessionToken = const Uuid().v4();
  }

  void endSearchSession() {
    _sessionToken = null;
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is LatLng) {
      initialSourceLocation = Get.arguments as LatLng;
      selectedSourceLocation.value = initialSourceLocation;
      getSourceAddressName(initialSourceLocation, "Current Location");
    }
    loadSources();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    endSearchSession();
    super.onClose();
  }

  void clearSearch() {
    searchText.value = '';
    searchResults.clear();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    isSearching.value = false;
    endSearchSession();
  }

  void onSearchChanged(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      _debounce?.cancel();
      return;
    }

    if (_sessionToken == null) {
      startNewSearchSession();
    }

    isSearching.value = true;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final result = await _mapRepo.searchPlaces(query, _sessionToken!);
        if (result.isOkay) {
          searchResults.value = result.predictions;
        } else {
          Get.snackbar('Error',
              result.errorMessage ?? 'Failed to search for places');
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        isSearching.value = false;
      }
    });
  }

  Future<PlaceDetailsResult?> getPlaceDetails(String placeId) async {
    if (_sessionToken == null) {
      Get.snackbar('Error', 'Session expired. Please search again.');
      return null;
    }

    final dio = Dio();
    final url = 'https://maps.googleapis.com/maps/api/place/details/json';
    final parameters = {
      'place_id': placeId,
      'fields': 'name,geometry',
      'key': googleApiKey, // Using the key from app_constants.dart
      'sessiontoken': _sessionToken,
    };

    try {
      final response = await dio.get(url, queryParameters: parameters);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'OK') {
          final result = data['result'];
          final location = result['geometry']['location'];
          final lat = location['lat'];
          final lng = location['lng'];
          final name = result['name'];

          if (lat != null && lng != null) {
            return PlaceDetailsResult(
              lat: lat,
              lng: lng,
              name: name as String?,
            );
          } else {
            throw Exception('Location data is missing in the response.');
          }
        } else {
          throw Exception('Google Places API Error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to load place details: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get place details: ${e.toString()}');
      return null;
    }
  }

  Future<void> selectDestination(String placeId) async {
    try {
      final details = await getPlaceDetails(placeId);
      if (details == null) {
        throw Exception('Invalid place details');
      }

      endSearchSession(); // End session on successful selection

      final destinationLatLng = LatLng(details.lat, details.lng);

      if (selectedSourceLocation.value != null) {
        final result = {
          'source': selectedSourceLocation.value!,
          'destination': destinationLatLng,
        };
        Get.back(result: result);
      } else {
        Get.snackbar('Error', 'Please select a source location first.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location details.');
    }
  }

  Future<void> getSourceAddressName(
    LatLng coordinates,
    String defaultName,
  ) async {
    selectedSourceText.value = "Fetching address...";
    try {
      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final address = [
          placemark.street,
          placemark.locality,
          placemark.subAdministrativeArea,
        ].where((element) => element != null && element.isNotEmpty).join(', ');
        selectedSourceText.value = address.isNotEmpty ? address : defaultName;
      } else {
        selectedSourceText.value = defaultName;
      }
    } catch (e) {
      selectedSourceText.value = defaultName;
    }
  }

  Future<void> loadSources() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/maps/sources.json',
      );
      final List<dynamic> data = json.decode(response);
      sources.value = data.map((item) => LocationPoint.fromJson(item)).toList();
    } catch (e) {
      Get.snackbar('Error loading sources', e.toString());
    }
  }

  void selectSource(LocationPoint source) {
    selectedSourceLocation.value = source.toLatLng();
    selectedSourceText.value = source.name;
  }

  void selectCurrentLocation() {
    selectedSourceLocation.value = initialSourceLocation;
    getSourceAddressName(initialSourceLocation, "Current Location");
  }
}
