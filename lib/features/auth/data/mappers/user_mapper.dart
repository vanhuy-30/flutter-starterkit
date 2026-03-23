import 'package:flutter_starter_kit/features/auth/data/models/user_model.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}

extension UserEntityMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}
