import 'package:flutter/material.dart';
import 'package:polar_sun/screens/parks.dart';
import '../buttons/screen_button.dart';
import 'herb.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ScreenButton("Цифровой гербарий", "lib/assets/herbarium.png", Herb()),
          ScreenButton("Флора", "lib/assets/flora.png", Herb()),
          ScreenButton("Заповедники и сады", "lib/assets/sady.png", Parks()),
        ],
      ),
    );
  }
}
