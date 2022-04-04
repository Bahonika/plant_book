import 'package:flutter/material.dart';

import 'screen_button.dart';
import '../screens/about.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      // Drawer Header with main info and logo of polar sun
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              currentAccountPicture: Image.asset(
                "lib/assets/logo.png",
              ),
              currentAccountPictureSize: Size(80, 80),
              accountName: Text(
                  "Проект Цифровой гербарий,\nсозданный студентами МАГУ",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              accountEmail: null,
            ),
          ),

          // Buttons with link to info about and our site
          Column(
            children: [
              SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 45)),
                child: Text("О нас"),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About())),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.6, 45)),
                  onPressed: null,
                  child: Text("Наш сайт"))
            ],
          ),
    ]));
  }
}
