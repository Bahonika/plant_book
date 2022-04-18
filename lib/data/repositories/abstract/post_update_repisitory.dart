import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/abstract/basic.dart';


import '../../entities/abstract/postable.dart';
import 'api.dart';

abstract class PostUpdateRepository<T extends Postable> extends BasicRepository<T>{

  String get idAlias;

  Future<int> create(T entity, File file, AuthorizedUser user) async{
    var uri = Uri.https(Api.siteRoot, apiPath());
    var dio = Dio();
    var response = await dio.post("https://" + Api.siteRoot+apiPath(),
        data: entity.toJson(),
        options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Token ' + user.token}
        ));
    var status = response.statusCode;
    if (status == 201){
      return response.data[idAlias];
    }
    throw HttpException("can't post to $uri Status: $status");
  }


}