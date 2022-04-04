import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polar_sun/screens/main_menu.dart';
import 'package:polar_sun/templates/main_drawer.dart';
import 'package:polar_sun/utils/theme_data.dart';

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
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Полярное солнце',
          ),
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            const MainMenu(),
            Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Image.asset(
                      "lib/assets/sprouts.png",
                      fit: BoxFit.fitWidth,
                    )))
          ],
        ),
      ),
    );
  }
}
