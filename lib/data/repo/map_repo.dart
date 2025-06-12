import 'package:flutter_google_maps_webservices/places.dart';
import 'package:blinkit_clone/core/app_constants.dart';

class MapRepo {
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);

  Future<PlacesAutocompleteResponse> searchPlaces(
    String input,
    String sessionToken,
  ) async {
    return await _places.autocomplete(input, sessionToken: sessionToken);
  }

  Future<PlacesDetailsResponse> getPlaceDetails(
    String placeId,
    String sessionToken,
  ) async {
    final response = await _places.getDetailsByPlaceId(
      placeId,
      fields: ['geometry', 'name', 'formatted_address'],
      sessionToken: sessionToken,
    );
    
    if (response.isOkay) {
      return response;
    } else {
      throw Exception(response.errorMessage ?? 'Failed to get place details');
    }
  }
}
