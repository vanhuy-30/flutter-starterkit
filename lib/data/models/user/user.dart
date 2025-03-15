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
  late String email;

  @HiveField(3)
  final String avatarUrl;

  @HiveField(4)
  final bool isPremium;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.isPremium = false,
  });

  // Convert from Map (used when get data from API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      isPremium: json['is_premium'] ?? false,
    );
  }

  // Convert to Map (used when saving data to Local)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'is_premium': isPremium,
    };
  }
}
