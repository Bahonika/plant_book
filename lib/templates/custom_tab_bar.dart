import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.controller, required this.tabs}) : super(key: key);

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthScale = screenWidth > 1360
        ? 0.3
        : screenWidth > 1000
        ? 0.4
        : 0.5;

    return Container(
        width: screenWidth * widthScale,
        child: Theme(
          data: ThemeData(
          ),
          child: TabBar(
            indicatorColor: Colors.red,
            controller: controller,
            tabs: tabs,
          ),
        ));
  }
}