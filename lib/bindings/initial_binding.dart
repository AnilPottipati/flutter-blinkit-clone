import 'package:get/get.dart';
import 'package:blinkit_clone/data/controller/cart_controller.dart';
import 'package:blinkit_clone/data/controller/map_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController(), permanent: true);
    Get.put(MapController(), permanent: true);
  }
}
