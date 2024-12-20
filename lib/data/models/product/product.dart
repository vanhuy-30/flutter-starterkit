import 'package:flutter_starter_kit/data/models/type_ids.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: productTypeId)
class Product extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late double price;

  @HiveField(3)
  late int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
}
