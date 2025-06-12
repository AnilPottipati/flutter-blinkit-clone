import 'package:get/get.dart';
import 'product_model.dart';

class CartItem {
  final Product product;
  RxInt quantity;

  CartItem({required this.product, int initialQuantity = 1}) 
      : quantity = initialQuantity.obs;

  double get totalPrice => product.price * quantity.value;

  // For equality based on product, useful for checking if a product is already in cart
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          product == other.product; // Compare based on product equality

  @override
  int get hashCode => product.hashCode;
}
