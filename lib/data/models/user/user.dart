import 'package:flutter_starter_kit/data/models/type_ids.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: userTypeId)
class User extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int age;

  @HiveField(3)
  late String email;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
  });
}
