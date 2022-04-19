import 'dart:io';

import 'package:polar_sun/data/entities/abstract/postable.dart';
import 'package:polar_sun/data/repositories/abstract/post_update_repisitory.dart';
import 'package:http/http.dart' as http;

import '../../entities/user.dart';
import 'api.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

abstract class MultipartRepository<T extends Postable>
    extends PostUpdateRepository<T> {
  Future<FormData> _prepareData(T entity) async {
    var fields = entity.toJson();
    var files = entity.getFiles();
    for (final key in files.keys) {
      File file = files[key]!;
      fields[key] = await MultipartFile.fromFile(file.path,
          filename: basename(file.path));
    }
    return FormData.fromMap(fields);
  }

  @override
  Future<int> create(T entity, File file, AuthorizedUser user) async {
    var uri = Uri.https(Api.siteRoot, apiPath());
    var request = http.MultipartRequest("POST", uri);
    request.headers[HttpHeaders.authorizationHeader] = user.token;

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);

    var formData = await _prepareData(entity);
    var response = await http.post(
      uri,
      headers: {HttpHeaders.authorizationHeader: 'Token ' + user.token},
      body: formData,
    );
    var status = response.statusCode;
    print(response);
    if (status == 201) {
      return int.parse(response.body);
    }
    throw HttpException("can't post to $uri Status: $status");
  }

  // @override
  // Future<void> update(T entity, int id, AuthorizedUser user) async {
  //   var dio = Dio();
  //   var formData = await _prepareData(entity);
  //   var response = await dio.put(apiIdPath(id).toString(),
  //       data: formData,
  //       options: Options(headers: {'Authorization': "Token ${user.token}"}));
  //   var status = response.statusCode;
  //   if (status != 201) {
  //     throw HttpException("can't update Status: $status");
  //   }
  // }
}
