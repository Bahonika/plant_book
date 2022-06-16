import 'dart:io';

import 'package:polar_sun/data/repositories/abstract/api.dart';
import 'package:polar_sun/screens/register_page.dart';
import 'package:polar_sun/utils/utf_8_convert.dart';

import '../entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthorizationException implements Exception {
  String getErrorMessage() {
    return "Неверные данные пользователя";
  }
}

class RegisterUser extends Api {
  @override
  final String apiEndpoint = "register";

  Future<AuthorizedUser> register(String username, String firstName,
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
    final body = json.decode(response.body);
    if (response.statusCode == 201) {
      return AuthorizedUser.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      if (body["username"] != null) {
        usernameError = utf8convert(body["username"].toString());
      }
      if (body["email"] != null) {
        emailError = utf8convert(body["email"].toString());
      }
      if (body["password"] != null) {
        passwordError = utf8convert(body["password"].toString());
      }
      throw AuthorizationException();
    }
    if (body["username"] != null) {
      usernameError = utf8convert(body["username"].toString());
    }
    if (body["email"] != null) {
      emailError = utf8convert(body["email"].toString());
    }
    if (body["password"] != null) {
      passwordError = utf8convert(body["password"].toString());
    }
    throw HttpException("can't access $uri Status: $status");
  }
}
