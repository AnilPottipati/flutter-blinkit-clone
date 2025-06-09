class Product {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  // Add other relevant product details like description, category, etc.

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  // For equality and hash code, useful for Set or Map operations
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
