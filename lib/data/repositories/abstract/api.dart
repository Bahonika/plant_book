abstract class Api {

  // static const String siteRoot = "projects.masu.edu.ru";
  // static const String apiRoot = "/herbarium/api/";

  static const String siteRoot = "localhost:8000";
  static const String apiRoot = "/herbarium/api/";
  String get apiEndpoint;

  String apiPath() => apiRoot+apiEndpoint;

}