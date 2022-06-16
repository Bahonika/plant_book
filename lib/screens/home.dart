import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar_sun/utils/device_screen_type.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Widget polarSunAlias() {
      return Text(
        "Полярное солнце",
        style: GoogleFonts.montserratAlternates(
          fontSize: MediaQuery.of(context).size.longestSide * 0.057 < 30
              ? 30
              : MediaQuery.of(context).size.longestSide * 0.057,
          fontWeight: FontWeight.w800,
          color: const Color.fromRGBO(251, 150, 0, 1),
          shadows: <Shadow>[
            const Shadow(
              offset: Offset(5, 5),
              blurRadius: 3.0,
              color: Color.fromRGBO(0, 0, 0, 0.36),
            ),
            const Shadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              color: Color.fromRGBO(248, 74, 0, 0.75),
            ),
          ],
        ),
      );
    }

    Widget biodiversityAlias() {
      return Text("Биоразнообразие северной природы",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.longestSide * 0.018 < 16
                  ? 16
                  : MediaQuery.of(context).size.longestSide * 0.018,
              letterSpacing: 7));
    }

    double widthFactor =
        getDeviceType(MediaQuery.of(context)) == DeviceScreenType.desktop
            ? 0.29
            : 0.5;
    double heightFactor =
        getDeviceType(MediaQuery.of(context)) == DeviceScreenType.desktop
            ? 0.15
            : 0.15;
    double fontSize =
        getDeviceType(MediaQuery.of(context)) == DeviceScreenType.desktop
            ? 30
            : 16;

    // Widget homePageButton(String assetName, String buttonText) {
    //   return SizedBox(
    //       height: MediaQuery.of(context).size.shortestSide * heightFactor,
    //       width: MediaQuery.of(context).size.longestSide * widthFactor,
    //       child: ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //               primary: Color.fromRGBO(250, 250, 250, 0.85),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               elevation: 2),
    //           onPressed: () {},
    //           child: Row(children: [
    //             Image.asset(assetName),
    //             Flexible(
    //                 child: Text(
    //               buttonText,
    //               style: TextStyle(
    //                 fontSize: fontSize,
    //               ),
    //               softWrap: true,
    //                   textAlign: TextAlign.center,
    //             ))
    //           ])));
    // }
    //
    // Widget herbariumButton() {
    //   return homePageButton(
    //       "lib/assets/herbarium.png", "Цифровой гербарий МАГУ");
    // }
    //
    // Widget gardenButton() {
    //   return homePageButton(
    //       "lib/assets/flora.png", "Заповедники и ботанические сады");
    // }

    Widget mobileView() {
      return Stack(children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset(
            'lib/assets/home_screen_mobile.png',
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  polarSunAlias(),
                  const SizedBox(height: 20),
                  biodiversityAlias(),
                  const SizedBox(height: 100),
                  Image.asset("lib/assets/masu.png", height: 250),
                ]))
      ]);
    }

    Widget desktopView() {
      return Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset('lib/assets/home_screen.png'),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                polarSunAlias(),
                const SizedBox(height: 10),
                biodiversityAlias(),
                const SizedBox(height: 200),
                Image.asset("lib/assets/masu.png", height: 250),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      );
    }

    return getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
        ? mobileView()
        : desktopView();
  }
}
