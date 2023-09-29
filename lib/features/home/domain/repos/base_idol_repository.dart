import 'package:flutter_eval/features/home/domain/entities/idol_entity.dart';
import 'package:flutter_eval/features/shared/data/models/response.dart';

abstract class BaseIdolRepository {
  Future<Response<List<IdolEntity>?>> list();
}
