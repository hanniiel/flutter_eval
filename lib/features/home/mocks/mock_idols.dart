import 'package:flutter_eval/features/home/data/models/idol_model.dart';
import 'package:flutter_eval/features/home/data/repos/idol_repository.dart';
import 'package:flutter_eval/features/home/domain/entities/idol_entity.dart';
import 'package:flutter_eval/features/shared/data/models/response.dart';

final mockIdolsEntity = List.generate(
    5,
    (index) => IdolEntity(
        id: '${index + 1}',
        name: 'san$index',
        hangul: 'Sna',
        gender: Gender.F,
        birthday: DateTime.now(),
        debut: DateTime.now(),
        active: true,
        avatar: 'https://imgur.com/4QH5wDt',
        v: 0,
        profession: [Profession.I],
        group: null));

final mockIdols = mockIdolsEntity.map((e) => IdolModel.fromEntity(e)).toList();

class MockIdolRepository implements IdolRepository {
  @override
  Future<Response<List<IdolEntity>?>> list() async {
    await Future.delayed(const Duration(seconds: 2));

    return Response(message: 'good', data: mockIdolsEntity);
  }
}
