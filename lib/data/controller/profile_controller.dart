import 'package:get/get.dart';
import 'package:blinkit_clone/data/controller/cart_controller.dart';
import 'package:blinkit_clone/data/controller/map_controller.dart';
import 'package:blinkit_clone/routes/route.dart';

class ProfileController extends GetxController {
  // User Information - Observables for reactivity
  final RxString userName = 'Charan'.obs; // Placeholder
  final RxString userPhoneNumber = '7989917291'.obs; // Placeholder
  final RxString userDob = '27 Dec 2004'.obs; // Placeholder

  // App Information
  final String appVersion = 'blinkit v17.25.2'; // Placeholder

  // TODO: Implement actual user data fetching (e.g., from a UserRepository)

  // --- Navigation/Action Methods ---
  // These would typically navigate to other screens or perform actions

  void navigateToYourOrders() {
    // TODO: Implement navigation to Your Orders screen
    Get.snackbar('Navigation', 'To Your Orders Screen');
  }

  void navigateToBookmarkedRecipes() {
    // TODO: Implement navigation to Bookmarked Recipes screen
    Get.snackbar('Navigation', 'To Bookmarked Recipes Screen');
  }

  void navigateToAddressBook() {
    // TODO: Implement navigation to Address Book screen
    Get.snackbar('Navigation', 'To Address Book Screen');
  }

  void navigateToGstDetails() {
    // TODO: Implement navigation to GST Details screen
    Get.snackbar('Navigation', 'To GST Details Screen');
  }

  void navigateToEGiftCards() {
    // TODO: Implement navigation to E-Gift Cards screen
    Get.snackbar('Navigation', 'To E-Gift Cards Screen');
  }

  void navigateToWallet() {
    // TODO: Implement navigation to Wallet screen
    Get.snackbar('Navigation', 'To Wallet Screen');
  }

  void navigateToBlinkitMoney() {
    // TODO: Implement navigation to Blinkit Money screen
    Get.snackbar('Navigation', 'To Blinkit Money Screen');
  }

  void navigateToPaymentSettings() {
    // TODO: Implement navigation to Payment Settings screen
    Get.snackbar('Navigation', 'To Payment Settings Screen');
  }

  void navigateToCollectedRewards() {
    // TODO: Implement navigation to Collected Rewards screen
    Get.snackbar('Navigation', 'To Collected Rewards Screen');
  }

  void shareApp() {
    // TODO: Implement app sharing functionality
    Get.snackbar('Action', 'Share App');
  }

  void navigateToAboutUs() {
    // TODO: Implement navigation to About Us screen
    Get.snackbar('Navigation', 'To About Us Screen');
  }

  void getFeedingIndiaReceipt() {
    // TODO: Implement logic for Feeding India receipt
    Get.snackbar('Action', 'Get Feeding India Receipt');
  }

  void navigateToAccountPrivacy() {
    // TODO: Implement navigation to Account Privacy screen
    Get.snackbar('Navigation', 'To Account Privacy Screen');
  }

  void navigateToNotificationPreferences() {
    // TODO: Implement navigation to Notification Preferences screen
    Get.snackbar('Navigation', 'To Notification Preferences Screen');
  }

  void logout() {
    // Clear user-specific data from controllers that are part of the session
    if (Get.isRegistered<CartController>()) {
      Get.find<CartController>().clearCart();
    }
    if (Get.isRegistered<MapController>()) {
      Get.find<MapController>().resetController();
    }

    // Navigate to the splash screen, which will handle the auth flow.
    // Using offAllNamed removes all previous routes from the stack.
    Get.offAllNamed(Routes.splash);

    // Optionally, show a confirmation message
    Get.snackbar(
      'Logged Out',
      'You have been successfully logged out.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
