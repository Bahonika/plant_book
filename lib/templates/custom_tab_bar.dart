import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.controller, required this.tabs})
      : super(key: key);

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 65,
        color: Theme.of(context).colorScheme.primary,
        child: TabBar(
          indicatorColor: Theme.of(context).colorScheme.primary,
          controller: controller,
          tabs: tabs,
        ));
  }
}
