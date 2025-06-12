import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryAddressController extends GetxController {
  final Rxn<LatLng> selectedLatLng = Rxn<LatLng>();
  final RxString selectedAddress = ''.obs;

  bool get isAddressSelected => selectedLatLng.value != null;

  void setAddress(LatLng latlng, String address) {
    selectedLatLng.value = latlng;
    selectedAddress.value = address;
  }

  void clear() {
    selectedLatLng.value = null;
    selectedAddress.value = '';
  }
}
