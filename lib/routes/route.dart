import 'package:blinkit_clone/view/screens/maps/map_screen.dart';
import 'package:get/get.dart';
import 'package:blinkit_clone/view/screens/auth/login_screen.dart';
import 'package:blinkit_clone/view/screens/auth/otp_screen.dart';
import '../view/screens/splash_screen.dart';
import '../view/wrappers/bottom_navigation_wrapper.dart';
import '../view/screens/cart_screen.dart';
import '../view/screens/payment_success_screen.dart';
import '../view/screens/my_orders_screen.dart';
import '../view/screens/auth/PermissionGate.dart';
import '../view/screens/maps/search_screen.dart';
import '../view/screens/maps/address_picker_screen.dart';
import '../view/screens/category_products_screen.dart';
import '../view/screens/category_screen.dart';

class Routes {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String categories = '/categories';
  static const String paymentSuccess = '/payment-success';
  static const String myOrderDetails = '/my-order-details';
  static const String permissionGate = '/permission-gate';
  static const String map = '/map';
  static const String search = '/search';
  static const String addressPicker = '/address-picker';

  static final List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: permissionGate, page: () => const PermissionGate()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(
      name: otp,
      page: () {
        final String phoneNumber = Get.arguments as String? ?? 'N/A';
        return OTPScreen(phoneNumber: phoneNumber);
      },
    ),
    GetPage(
      name: search,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: home,
      page: () => const BottomNavigationWrapper(),
    ),
    GetPage(name: cart, page: () => const CartScreen()),
    GetPage(name: paymentSuccess, page: () => const PaymentSuccessScreen()),
    GetPage(name: map, page: () => const MapScreen()),
    GetPage(name: myOrderDetails, page: () => const MyOrdersScreen()),
    GetPage(name: addressPicker, page: () => const AddressPickerScreen()),
    GetPage(
        name: CategoryProductsScreen.routeName,
        page: () => const CategoryProductsScreen()),
    GetPage(name: categories, page: () => const CategoryScreen()),
  ];
}
