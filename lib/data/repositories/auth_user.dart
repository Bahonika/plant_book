import 'dart:io';

import 'package:polar_sun/data/repositories/abstract/api.dart';

import '../entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthorizationException implements Exception {
  String getErrorMessage() {
    return "Неверные данные пользователя";
  }
}

String loginError = "";

class AuthUser extends Api {
  @override
  final String apiEndpoint = "login";

  Future<AuthorizedUser> auth(String username, String password) async {
    //TODO change for https before release
    var uri = Uri.https(Api.siteRoot, apiPath());
    // var uri = Uri.http(Api.siteRoot, apiPath());
    var response = await http
        .post(uri, body: {'username': username, 'password': password});
    var status = response.statusCode;
    if (response.statusCode == 200) {
      loginError = "";
      return AuthorizedUser.fromJson(convert.jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      loginError = "Ошибка входа, неправильный логин или пароль";
      throw AuthorizationException();
    }
    throw HttpException("can't access $uri Status: $status");
  }
}
