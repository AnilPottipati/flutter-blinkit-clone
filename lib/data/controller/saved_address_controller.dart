import 'package:get/get.dart';

import '../model/address_model.dart';

class SavedAddressController extends GetxController {
  final RxList<AddressModel> _savedAddresses = <AddressModel>[].obs;
  List<AddressModel> get savedAddresses => _savedAddresses;



  void addAddress(AddressModel address) {
    _savedAddresses.add(address);
  }

  void removeAddress(AddressModel address) {
    _savedAddresses.remove(address);
  }
}
