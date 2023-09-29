import 'dart:convert';
import 'dart:io';

import 'package:flutter_eval/features/home/domain/entities/idol_entity.dart';
import 'package:flutter_eval/features/home/domain/repos/base_idol_repository.dart';
import 'package:flutter_eval/features/shared/data/models/response.dart';
import 'package:http/http.dart' as http;

class IdolRepository implements BaseIdolRepository {
  @override
  Future<Response<List<IdolEntity>?>> list() async {
    //env vars for endpoints would be better
    //Self implemented API, Kpop Idols ranking
    final uri = Uri.parse(
      'https://kdaebak.netlify.app/api/v1/idol',
    );
    final res = await http.get(uri);

    //implement try catch wraper to execute response without any issues
    final idols = List<IdolEntity>.from(
      //using utf8 decoder due to korean characters
      json.decode(utf8.decode(res.bodyBytes)).map((x) => IdolEntity.fromMap(x)),
    );

    //Map list to Generic response useed accross all app
    return Response(
      data: idols,
      message: res.statusCode == HttpStatus.ok ? 'good' : 'bad',
      code: res.statusCode,
    );
  }
}
