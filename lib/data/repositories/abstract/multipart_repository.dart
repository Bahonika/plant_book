import 'dart:io';
// import 'dart:html';
// import 'dart:typed_data';

// import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:polar_sun/data/entities/abstract/postable.dart';
import 'package:polar_sun/data/repositories/abstract/post_update_repisitory.dart';

import '../../entities/user.dart';
import 'api.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

abstract class MultipartRepository<T extends PostableWithMultipart>
    extends PostUpdateRepository<T> {
  Future<FormData> _prepareData(T entity) async {
    var fields = entity.toJson();
    var files = entity.getFiles();

    for (final key in files.keys) {
      File file = files[key]!;

      // if (kIsWeb) {
      //   var bytes = file.readAsBytesSync();
      //   fields[key] = await MultipartFile.fromBytes(bytes,
      //       filename: basename(file.path),
      //       contentType: MediaType("image", "jpеg"));
      // } else {
        fields[key] = await MultipartFile.fromFile(file.path,
            filename: basename(file.path),
            contentType: MediaType("image", "jpеg"));
      // }
    }

    return FormData.fromMap(fields);
  }

  @override
  Future<int> create(T entity, AuthorizedUser user) async {
    var uri = Uri.https(Api.siteRoot, apiPath());
    var dio = Dio();
    var formData = await _prepareData(entity);
    var response = await dio.post("https://" + Api.siteRoot + apiPath(),
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Token ' + user.token}));
    var status = response.statusCode;
    if (status == 201) {
      return response.data[idAlias];
    }
    throw HttpException("can't post to $uri Status: $status");
  }

  @override
  Future<void> update(T entity, int id, AuthorizedUser user) async {
    var dio = Dio();
    var formData = await _prepareData(entity);
    var response = await dio.put(apiIdPath(id).toString(),
        data: formData,
        options: Options(headers: {'Authorization': "Token ${user.token}"}));
    var status = response.statusCode;
    if (status != 201) {
      throw HttpException("can't update Status: $status");
    }
  }
}
