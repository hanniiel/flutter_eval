import 'package:equatable/equatable.dart';
import 'package:flutter_eval/features/home/domain/entities/idol_entity.dart';

class IdolModel extends Equatable {
  final String name, avatar, hangul;

  const IdolModel({
    required this.name,
    required this.avatar,
    required this.hangul,
  });

  factory IdolModel.fromEntity(IdolEntity entity) => IdolModel(
      name: entity.name, avatar: entity.avatar, hangul: entity.hangul);

  @override
  List<Object?> get props => [name];
}
