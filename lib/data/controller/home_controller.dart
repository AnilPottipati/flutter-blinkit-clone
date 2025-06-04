import 'package:get/get.dart';
import '../model/product.dart';
import '../repo/product_repo.dart';

class HomeController extends GetxController {
  final ProductRepo _productRepo;
  
  HomeController(this._productRepo);
  
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = true.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
  
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final result = await _productRepo.getProducts();
      products.assignAll(result);
    } catch (e) {
      // Handle error
      // print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }
}
