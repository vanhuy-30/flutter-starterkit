import 'package:flutter_starter_kit/data/models/product/product.dart';
import 'package:flutter_starter_kit/data/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  static const String userBoxName = 'users';
  static const String productBoxName = 'products';

  /// initial Hive
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ProductAdapter());

    if (!Hive.isBoxOpen(userBoxName)) {
      await Hive.openBox<User>(userBoxName);
    }
    if (!Hive.isBoxOpen(productBoxName)) {
      await Hive.openBox<Product>(productBoxName);
    }
  }

  // Box getters
  Box<User> get userBox => Hive.box<User>(userBoxName);
  Box<Product> get productBox => Hive.box<Product>(productBoxName);

  // User operations
  Future<void> addUser(User user) async {
    await userBox.put(user.id, user);
  }

  Future<void> deleteUser(int id) async {
    await userBox.delete(id);
  }

  Future<User?> getUserById(int id) async {
    return userBox.get(id);
  }

  List<User> getAllUsers() {
    return userBox.values.toList();
  }

  // Product operations
  Future<void> addProduct(Product product) async {
    await productBox.put(product.id, product);
  }

  Future<void> deleteProduct(int id) async {
    await productBox.delete(id);
  }

  Future<Product?> getProductById(int id) async {
    return productBox.get(id);
  }

  List<Product> getAllProducts() {
    return productBox.values.toList();
  }

  // clear all hive data
  Future<void> clearAll() async {
    await userBox.clear();
    await productBox.clear();
  }

  // close Hive
  Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
