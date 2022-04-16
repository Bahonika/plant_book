import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/screens/about.dart';
import 'package:polar_sun/screens/herb.dart';
import 'package:polar_sun/screens/login_page.dart';
import 'package:polar_sun/templates/box_shadow.dart';
import 'package:polar_sun/templates/custom_tab.dart';
import 'package:polar_sun/templates/custom_tab_bar.dart';
import 'package:polar_sun/utils/content_view.dart';
import 'package:polar_sun/utils/device_screen_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'add.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({Key? key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late User user;
  late double screenHeight;
  late double screenWidth;
  late TabController tabController;

  List<ContentView?> contentViews = [];

  checkRole() {
    contentViews.addAll([
      ContentView(
          tab: const CustomTab(
            title: "Главная",
          ),
          content: const Home()),
      ContentView(
          tab: const CustomTab(
            title: "Гербарий",
          ),
          content: Herb(user: user)),
      ContentView(
          tab: const CustomTab(
            title: "О нас",
          ),
          content: const About())
    ]);
    if (user.role == User.moder) {
      contentViews.add(ContentView(
          tab: const CustomTab(
            title: "Добавить",
          ),
          content: const Add()));
    }
  }

  void logout() async {
    var prefs = await SharedPreferences.getInstance();
    widget.user!.clear(prefs);
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  IconButton logoutButton() {
    return IconButton(
        onPressed: logout,
        icon: Transform.rotate(
            angle: math.pi,
            child: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            )));
  }

  Future<void> getData() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    user = widget.user ?? await restoreFromSharedPrefs(sharedPrefs);
  }

  @override
  void initState() {
    user = widget.user!;
    getData();
    checkRole();
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
        appBar: deviceType == DeviceScreenType.mobile
            ? AppBar(
                title: logoutButton(),
              )
            : null,
        body: Container(
          decoration: BoxDecoration(boxShadow: boxShadow(context)),
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
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primary,
            child: logoutButton()),
        CustomTabBar(
            controller: tabController,
            tabs: contentViews.map((e) => e!.tab).toList()),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: contentViews.map((e) => e!.content).toList(),
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
            // Container(
            //     color: Theme.of(context).colorScheme.primary,
            //     width: MediaQuery.of(context).size.width,
            //     height: 65,
            //     child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //       IconButton(
            //         onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
            //         icon: const Icon(Icons.menu_rounded),
            //         color: Colors.grey,
            //       ),
            //     ])),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: contentViews.map((e) => e!.content).toList(),
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
                title: Text(e!.tab.title),
                onTap: () {
                  tabController.index = contentViews.indexOf(e);
                  scaffoldKey.currentState!.openDrawer();
                }))
            .toList(),
      ),
    );
  }
}
