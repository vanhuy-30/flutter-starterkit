import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/data/models/product/product.dart';

class ProductRepository {
  final HiveService _hiveService = HiveService();

  Future<void> addProduct(Product product) {
    return _hiveService.addProduct(product);
  }

  Future<void> deleteProduct(String id) {
    return _hiveService.deleteProduct(id);
  }

  Future<void> updateProduct(Product product) {
    return _hiveService.updateProduct(product);
  }

  List<Product> getAllProducts() {
    return _hiveService.getAllProducts();
  }
}
