import 'package:get/get.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/splash_screen.dart';
import '../view/wrappers/bottom_navigation_wrapper.dart';

class Routes {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderAgain = '/order-again';
  static const String categories = '/categories';
  static const String print = '/print';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () => const BottomNavigationWrapper(),
    ),
    // Add more routes as needed
  ];
}
