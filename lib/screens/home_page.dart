import 'package:flutter/material.dart';
import 'package:polar_sun/screens/about.dart';
import 'package:polar_sun/screens/herb.dart';
import 'package:polar_sun/templates/custom_tab.dart';
import 'package:polar_sun/templates/custom_tab_bar.dart';
import 'package:polar_sun/utils/content_view.dart';
import 'package:polar_sun/utils/device_screen_type.dart';

import 'add.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late double screenHeight;
  late double screenWidth;
  late TabController tabController;

  List<ContentView> contentViews = [
    ContentView(
        tab: const CustomTab(
          title: "Главная",
        ),
        content: const Home()),
    ContentView(
        tab: const CustomTab(
          title: "О нас",
        ),
        content: const About()),
    ContentView(
        tab: const CustomTab(
          title: "Гербарий",
        ),
        content: const Herb()),
    ContentView(
        tab: const CustomTab(
          title: "Добавить",
        ),
        content: const Add()),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var deviceType = getDeviceType(MediaQuery.of(context));

    return Scaffold(
        endDrawer: drawer(),
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                color: Color.fromRGBO(96, 154, 76, 0.5),
              ),
              BoxShadow(
                color: Theme.of(context).backgroundColor,
                spreadRadius: -12.0,
                blurRadius: 150.0,
              ),
            ],
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            if (deviceType == DeviceScreenType.desktop) {
              return desktopView();
            } else {
              return mobileView();
            }
          }),
        ));
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTabBar(
            controller: tabController,
            tabs: contentViews.map((e) => e.tab).toList()),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: contentViews.map((e) => e.content).toList(),
          ),
        )
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                color: Theme.of(context).colorScheme.primary,
                width: MediaQuery.of(context).size.width,
                height: 65,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                    icon: const Icon(Icons.menu_rounded),
                    color: Colors.grey,
                  ),
                ])),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: contentViews.map((e) => e.content).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: contentViews
            .map((e) => ListTile(
                title: Text(e.tab.title),
                onTap: () {
                  tabController.index = contentViews.indexOf(e);
                  scaffoldKey.currentState!.openDrawer();
                }))
            .toList(),
      ),
    );
  }
}
