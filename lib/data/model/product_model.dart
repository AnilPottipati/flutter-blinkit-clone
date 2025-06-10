class Product {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final String mrp;
  final String discount;
  final String tag;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.mrp,
    required this.discount,
    required this.tag,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Helper to parse price strings like "₹757" to double
    double parsePrice(String priceString) {
      return double.tryParse(priceString.replaceAll('\u20B9', '').replaceAll(',', '')) ?? 0.0;
    }

    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: parsePrice(json['price'] as String), // Parse string to double
      imageUrl: json['imageUrl'] as String?,
      mrp: json['mrp'] as String,
      discount: json['discount'] as String,
      tag: json['tag'] as String,
    );
  }

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
