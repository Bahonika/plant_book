import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polar_sun/screens/main_menu.dart';
import 'package:polar_sun/templates/main_drawer.dart';

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
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(187, 197, 177, 1),
          backgroundColor: const Color.fromRGBO(187, 197, 177, 1),
          primaryColor: primary,
          canvasColor: const Color.fromRGBO(187, 197, 177, 1),
          textTheme: const TextTheme(
              displaySmall: TextStyle(color: Color.fromRGBO(233, 212, 0, 1))),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(onPrimary: Colors.black54)
              .copyWith(primaryContainer: const Color.fromRGBO(245, 245, 245, 0.6))
              .copyWith(primary: primary)
              .copyWith(secondary: const Color.fromRGBO(62, 151, 139, 1))),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Полярное солнце',
          ),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            MainMenu(),
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
