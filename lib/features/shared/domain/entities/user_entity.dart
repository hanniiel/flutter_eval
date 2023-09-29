import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? username;

  const UserEntity({
    this.name,
    this.username,
    this.email,
  });
}
