import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar_sun/templates/footer.dart';
import 'package:polar_sun/utils/device_screen_type.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget aboutProjectAlias() {
      return Text(
        "О проекте".toUpperCase(),
        style: GoogleFonts.montserrat(
          fontSize: MediaQuery.of(context).size.longestSide * 0.025,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(14, 53, 23, 1),
          letterSpacing: 7,
        ),
      );
    }

    Widget teamAlias() {
      return Padding(
          padding: EdgeInsets.symmetric(
              vertical: getDeviceType(MediaQuery.of(context)) ==
                      DeviceScreenType.desktop
                  ? MediaQuery.of(context).size.longestSide * 0.018
                  : 20),
          child: Text("Команда".toUpperCase(),
              style: GoogleFonts.montserrat(
                fontSize: getDeviceType(MediaQuery.of(context)) ==
                        DeviceScreenType.desktop
                    ? MediaQuery.of(context).size.longestSide * 0.025
                    : 30,
                fontWeight: FontWeight.w700,
                color: const Color.fromRGBO(14, 53, 23, 1),
                letterSpacing: 7,
              ),
              textAlign: getDeviceType(MediaQuery.of(context)) ==
                      DeviceScreenType.desktop
                  ? TextAlign.start
                  : TextAlign.center));
    }

    Widget desktopMemberTeamField(
        String textImageURL, String name, String role) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(300),
                // child: Image.asset(textImageURL, height: 260, width: 260)),
                child: Image.asset(textImageURL,
                    height: MediaQuery.of(context).size.longestSide * 0.13,
                    width: MediaQuery.of(context).size.longestSide * 0.13)),
            Flex(
              direction: Axis.vertical,
              children: [
                Text(name,
                    style: GoogleFonts.montserrat(
                      // fontSize: 24,
                      fontSize: MediaQuery.of(context).size.longestSide * 0.013,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 5,
                    )),
                Text(role,
                    style: GoogleFonts.montserrat(
                      fontSize: MediaQuery.of(context).size.longestSide * 0.011,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(84, 84, 84, 1),
                    ))
              ],
            )
          ],
        ),
      );
    }

    Widget mobileMemberTeamField(
        String textImageURL, String name, String role) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image.asset(textImageURL, height: 150, width: 150)),
            Flexible(
                child: Column(children: [
              Text(name,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3)),
              Text(role,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(84, 84, 84, 1),
                  ))
            ]))
          ]));
    }

    Widget desktopView() {
      return FooterView(
          flex: 10,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2,
                  vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  aboutProjectAlias(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "\"Полярное солнце\" - это проект направленный"
                          " на биоразнообразие мурманской области."
                          "\n\nНа сайте размещён цифровой гербарий МАГУ,"
                          " включающий коллекцию растений, произрастающих на территории"
                          " Мурманской области и собранных исследователями нашего "
                          "вуза во время экспедиций.",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  MediaQuery.of(context).size.longestSide *
                                      0.012,
                              letterSpacing: 3),
                        ),
                      ),
                      Image.asset('lib/assets/logo.png',
                          height:
                              MediaQuery.of(context).size.longestSide * 0.23,
                          width:
                              MediaQuery.of(context).size.longestSide * 0.23),
                    ],
                  ),
                  teamAlias(),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Проект был выполнен студентами Мурманского Арктического "
                          "государственного университета в рамках дисциплин "
                          "\"Университетский проект\" и \"Проект направленности (профиля)\".",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  MediaQuery.of(context).size.longestSide *
                                      0.012,
                              letterSpacing: 3),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      desktopMemberTeamField('lib/assets/Baginskii.jpg',
                          'Багинский Денис', 'Программист'),
                      desktopMemberTeamField('lib/assets/Markova.jpg',
                          'Маркова Варвара', 'Программист, дизайнер'),
                      desktopMemberTeamField('lib/assets/Projerin.jpg',
                          'Прожерин Дмитрий', 'Программист'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      desktopMemberTeamField('lib/assets/Surovets.jpg',
                          'Суровец Валерия', 'Биолог'),
                      desktopMemberTeamField(
                          'lib/assets/Moiseeva.jpg', 'Моисеева Нина', 'Биолог'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      desktopMemberTeamField('lib/assets/Miroshnikov.jpg',
                          'Мирошников Влад', 'Программист'),
                      desktopMemberTeamField('lib/assets/Andreev.jpg',
                          'Андреев Матвей', 'Программист'),
                    ],
                  ),
                ],
              ),
            )
          ],
          footer: footer(context));
    }

    Widget mobileView() {
      return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
          children: [
            Image.asset('lib/assets/logo.png', height: 252, width: 253),
            Text(
                "\"Полярное солнце\" - это проект направленный"
                " на биоразнообразие мурманской области.",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 20),
                textAlign: TextAlign.center),
            Text(
              "\nНа сайте размещён цифровой гербарий МАГУ,"
              " включающий коллекцию растений, произрастающих на территории"
              " Мурманской области и собранных исследователями нашего "
              "вуза во время экспедиций.",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400, fontSize: 16),
            ),
            teamAlias(),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Проект был выполнен студентами Мурманского Арктического "
                    "государственного университета в рамках дисциплин "
                    "\"Университетский проект\" и \"Проект направленности (профиля)\".",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            mobileMemberTeamField(
                'lib/assets/Baginskii.jpg', 'Багинский Денис', 'Программист'),
            mobileMemberTeamField('lib/assets/Markova.jpg', 'Маркова Варвара',
                'Программист, дизайнер'),
            mobileMemberTeamField(
                'lib/assets/Projerin.jpg', 'Прожерин Дмитрий', 'Программист'),
            mobileMemberTeamField(
                'lib/assets/Surovets.jpg', 'Суровец Валерия', 'Биолог'),
            mobileMemberTeamField(
                'lib/assets/Moiseeva.jpg', 'Моисеева Нина', 'Биолог'),
            mobileMemberTeamField(
                'lib/assets/Miroshnikov.jpg', 'Мирошников Влад', 'Программист'),
            mobileMemberTeamField(
                'lib/assets/Andreev.jpg', 'Андреев Матвей', 'Программист')
          ]);
    }

    return getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
        ? mobileView()
        : desktopView();
  }
}
