import 'order_item_model.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class Order {
  final String id;
  final List<OrderItem> items;
  final DateTime orderDate;
  final double totalAmount;
  final OrderStatus status;
  final String? shippingAddress; // Or a more complex Address object

  Order({
    required this.id,
    required this.items,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    this.shippingAddress,
  });
}
