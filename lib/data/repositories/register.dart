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

class RegisterUser extends Api {
  @override
  final String apiEndpoint = "register";

  Future<AuthorizedUser> auth(String username, String firstName,
      String lastName, String email, String password) async {
    var uri = Uri.https(Api.siteRoot, apiPath());
    var response = await http.post(uri, body: {
      'username': username,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      'password': password
    });
    var status = response.statusCode;
    if (response.statusCode == 201) {
      return AuthorizedUser.fromJson(convert.jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw AuthorizationException();
    }
    throw HttpException("can't access $uri Status: $status");
  }
}
