import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:polar_sun/data/entities/user.dart';
import 'dart:convert' as convert;

import 'package:polar_sun/data/repositories/abstract/api.dart';

abstract class BasicRepository<T> extends Api {
  Uri apiIdPath(int id) =>
      Uri.https(Api.siteRoot, Api.apiRoot + apiEndpoint + "/$id");

  T fromJson(json);

  Future<List<T>> getAll(
      {Map<String, String>? queryParams, AuthorizedUser? user}) async {
    //TODO change to https before release

    var uri = Uri.https(Api.siteRoot, apiPath(), queryParams);
    var response;
    try {
      response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        'Authorization': "Token ${user!.token}"
      });
    } catch (e) {
      throw Exception("Cant do this");
    }
    var status = response.statusCode;
    if (status == 200) {
      List<T> list = [];
      var json = convert.jsonDecode(response.body);
      for (final item in json) {
        list.add(fromJson(item));
      }
      return list;
    }
    throw HttpException("can't access $uri Status: $status");
  }
}
