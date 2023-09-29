import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eval/features/shared/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String? name,
    String? email,
    String? username,
  }) : super(
          name: name,
          username: username,
          email: email,
        );

  factory UserModel.fromFirebase(User user) => UserModel(
        name: user.displayName,
        email: user.email,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        username: json['username'],
        email: json['username'],
      );

  @override
  List<Object?> get props => [email];
}
