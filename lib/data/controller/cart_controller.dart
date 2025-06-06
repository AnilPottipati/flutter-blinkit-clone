import 'package:get/get.dart';
import '../model/cart_item_model.dart';
import '../model/product_model.dart';

class CartController extends GetxController {
  // Reactive list of cart items
  var cartItems = <CartItem>[].obs;

  // Rx observables for cart summary
  final RxDouble subtotalPrice = 0.0.obs;
  final RxDouble deliveryFee = 2.0.obs; // Example: Fixed delivery fee
  final RxDouble totalPrice = 0.0.obs;

  // Add a product to the cart
  void addItem(Product product) {
    try {
      // Check if the item already exists in the cart
      var existingItem = cartItems.firstWhere((item) => item.product.id == product.id);
      existingItem.quantity.value++;
    } catch (e) {
      // If not found, add as a new item
      cartItems.add(CartItem(product: product, initialQuantity: 1));
    }
    _updateCartTotals();
  }

  // Remove an item from the cart
  void removeItem(CartItem cartItem) {
    cartItems.remove(cartItem);
    _updateCartTotals();
  }

  // Increment quantity of an item
  void incrementQuantity(CartItem cartItem) {
    cartItem.quantity.value++;
    _updateCartTotals();
  }

  // Decrement quantity of an item
  void decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity.value > 1) {
      cartItem.quantity.value--;
      _updateCartTotals(); // Update totals if quantity just decremented
    } else {
      // If quantity is 1, remove the item (removeItem will update totals)
      removeItem(cartItem);
    }
  }

  // Get total number of unique items in the cart
  int get totalUniqueItems => cartItems.length;

  // Helper to get the CartItem for a specific product in the cart
  CartItem? getCartItemByProductId(String productId) {
    try {
      return cartItems.firstWhere((cartItem) => cartItem.product.id == productId);
    } catch (e) {
      // Product not found in cart
      return null;
    }
  }

  // Helper to get the quantity of a specific product in the cart
  int getProductQuantityInCart(String productId) {
    final cartItem = getCartItemByProductId(productId);
    return cartItem?.quantity.value ?? 0;
  }

  // Get total quantity of all items in the cart
  int get totalCartQuantity {
    int total = 0;
    for (var item in cartItems) {
      total += item.quantity.value;
    }
    return total;
  }

  // Method to update all cart totals
  void _updateCartTotals() {
    double currentSubtotal = 0.0;
    for (var item in cartItems) {
      currentSubtotal += item.totalPrice;
    }
    subtotalPrice.value = currentSubtotal;
    totalPrice.value = subtotalPrice.value + deliveryFee.value;
    // update(); // Not strictly necessary as Obx widgets listen to Rx variables
  }

  // Clear all items from the cart
  void clearCart() {
    cartItems.clear();
    _updateCartTotals();
  }

  // Check if a product is in the cart
  bool isProductInCart(Product product) {
    return cartItems.any((item) => item.product.id == product.id);
  }

  // Get the CartItem for a specific product, if it exists
  CartItem? getCartItem(Product product) {
     try {
      return cartItems.firstWhere((item) => item.product.id == product.id);
    } catch (e) {
      return null;
    }
  }
}
