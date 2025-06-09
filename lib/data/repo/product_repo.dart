import '../model/product.dart';
// import '../service/api_service.dart'; // ApiService not used with static data

class ProductRepo {
  // final ApiService _apiService; // Not used with static data
  
  // ProductRepo(this._apiService); // Not used with static data
  
  Future<List<Product>> getProducts() async {
    // try {
    //   final response = await _apiService.get('/products');
    //   final List<dynamic> data = response.data;
    //   return data.map((json) => Product.fromJson(json)).toList();
    // } catch (e) {
    //   throw Exception('Failed to fetch products: $e');
    // }

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return static product data
    return _staticProducts;
  }

  // Static product data
  static final List<Product> _staticProducts = [
    Product(
      id: '1',
      name: 'Fresh Apples',
      description: 'Crisp and juicy apples, perfect for a healthy snack.',
      price: 2.99,
      imageUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF?Text=Apples',
      rating: 4.5,
      stock: 100,
    ),
    Product(
      id: '2',
      name: 'Organic Bananas',
      description: 'A bunch of sweet, organic bananas.',
      price: 1.99,
      imageUrl: 'https://via.placeholder.com/150/FFFF00/000000?Text=Bananas',
      rating: 4.7,
      stock: 150,
    ),
    Product(
      id: '3',
      name: 'Whole Milk',
      description: 'Fresh whole milk, 1 gallon.',
      price: 3.49,
      imageUrl: 'https://via.placeholder.com/150/FFFFFF/000000?Text=Milk',
      rating: 4.2,
      stock: 75,
    ),
    Product(
      id: '4',
      name: 'Sourdough Bread',
      description: 'Artisan sourdough bread, freshly baked.',
      price: 4.99,
      imageUrl: 'https://via.placeholder.com/150/D2B48C/000000?Text=Bread',
      rating: 4.8,
      stock: 50,
    ),
    Product(
      id: '5',
      name: 'Free-Range Eggs',
      description: 'A dozen large free-range eggs.',
      price: 3.99,
      imageUrl: 'https://via.placeholder.com/150/F5F5DC/000000?Text=Eggs',
      rating: 4.6,
      stock: 80,
    ),
  ];
}

