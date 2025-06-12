import 'product_model.dart';

class OrderItem {
  final Product product;
  final int quantity;
  final double priceAtPurchase; // Price of the product when the order was placed

  OrderItem({
    required this.product,
    required this.quantity,
    required this.priceAtPurchase,
  });

  double get totalPrice => priceAtPurchase * quantity;
}
