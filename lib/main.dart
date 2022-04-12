import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/screens/home_page.dart';
import 'package:polar_sun/screens/login_page.dart';
import 'package:polar_sun/utils/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(75, 121, 55, 1.0);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primary,
        systemNavigationBarColor: primary,
      ),
    );

    return MaterialApp(
      title: "Полярное Солнце",
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: const Redirection());
  }
}


// The statefulWidget class required for redirecting to the homepage if the user was logged in earlier.
class Redirection extends StatefulWidget {
  const Redirection({Key? key}) : super(key: key);

  @override
  _RedirectionState createState() => _RedirectionState();
}

class _RedirectionState extends State<Redirection> {
  User? user;

  restoreUser() async {
    var prefs = await SharedPreferences.getInstance();
    user = await restoreFromSharedPrefs(prefs);
    setState(() {});
  }

  @override
  void initState() {
    restoreUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user != null ? HomePage(user: user) : const LoginPage();
  }
}
