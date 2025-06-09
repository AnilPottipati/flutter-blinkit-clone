class ProductItem {
  final String id;
  final String imageUrl;
  final String name;
  final String unit; // e.g., "500 ml", "0.95-1.05 kg"
  final String deliveryTime; // e.g., "10 MINS"
  final double? rating; // Optional
  final int? reviewCount; // Optional
  final double discountedPrice;
  final double? originalPrice; // Optional, if there's a discount
  final String? discountTag; // e.g., "27% OFF"
  final int? recipeCount; // Optional for "See X recipes"

  ProductItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.unit,
    required this.deliveryTime,
    this.rating,
    this.reviewCount,
    required this.discountedPrice,
    this.originalPrice,
    this.discountTag,
    this.recipeCount,
  });
}
