import 'package:flutter/material.dart';
import 'package:polar_sun/templates/custom_tab.dart';
import 'package:polar_sun/templates/custom_tab_bar.dart';
import 'package:polar_sun/utils/content_view.dart';
import 'package:polar_sun/utils/device_screen_type.dart';

import 'herb.dart';

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
        content: const Center()),
    ContentView(
        tab: const CustomTab(
          title: "О нас",
        ),
        content: const Center()),
    ContentView(
        tab: const CustomTab(
          title: "Гербарий",
        ),
        content: const Center(
          child: Herb(),
        )),
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
    print(deviceType);

    return Scaffold(
        appBar: AppBar(title: const Text("Главная")),
        endDrawer:
            deviceType == DeviceScreenType.mobile ? drawer() : SizedBox(),
        key: scaffoldKey,
        body: LayoutBuilder(builder: (context, constraints) {
          if (deviceType == DeviceScreenType.desktop) {
            return desktopView();
          } else {
            return mobileView();
          }
        }));
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
