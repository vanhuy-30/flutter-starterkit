import 'package:flutter_starter_kit/data/models/product/product.dart';
import 'package:flutter_starter_kit/data/models/user/user.dart';
import 'package:hive/hive.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  // Box getters
  Box<User> get userBox => Hive.box<User>('users');
  Box<Product> get productBox => Hive.box<Product>('products');

  // User operations
  Future<void> addUser(User user) async {
    await userBox.put(user.id, user);
  }

  Future<void> deleteUser(String id) async {
    await userBox.delete(id);
  }

  Future<void> updateUser(User user) async {
    await user.save();
  }

  List<User> getAllUsers() {
    return userBox.values.toList();
  }

  // Product operations
  Future<void> addProduct(Product product) async {
    await productBox.put(product.id, product);
  }

  Future<void> deleteProduct(String id) async {
    await productBox.delete(id);
  }

  Future<void> updateProduct(Product product) async {
    await product.save();
  }

  List<Product> getAllProducts() {
    return productBox.values.toList();
  }

  // Close all boxes
  Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
