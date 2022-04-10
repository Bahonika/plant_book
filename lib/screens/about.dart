import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar_sun/utils/device_screen_type.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget aboutProjectAlias() {
      return Text(
        "О проекте".toUpperCase(),
        style: GoogleFonts.montserrat(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(14, 53, 23, 1),
          letterSpacing: 7,
        ),
      );
    }

    Widget aboutTeamAlias() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: getDeviceType(MediaQuery.of(context)) == DeviceScreenType.desktop
            ? 36
            : 20),
        child: Text(
          "Команда".toUpperCase(),
          style: GoogleFonts.montserrat(
            fontSize: getDeviceType(MediaQuery.of(context)) == DeviceScreenType.desktop
                ? 48
                : 30,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(14, 53, 23, 1),
            letterSpacing: 7,
          ), textAlign: getDeviceType(MediaQuery.of(context)) == DeviceScreenType.desktop
            ? TextAlign.start
            : TextAlign.center));
    }

    Widget memberTeamField(String textImageURL, String name, String role) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image.asset(textImageURL, height: 260, width: 260)),
            Text(name,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 5,
                )),
            Text(role,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(84, 84, 84, 1),
                ))
          ],
        ),
      );
    }

    Widget memberTeamMobileField(
        String textImageURL, String name, String role) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image.asset(textImageURL, height: 150, width: 150)),
            Column(
              children: [
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
              ],
            ),
          ],
        ),
      );
    }

    Widget desktopView() {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 374, vertical: 80),
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                      fontSize: 24,
                      letterSpacing: 3),
                ),
              ),
              Image.asset('lib/assets/logo.png', height: 449, width: 459),
            ],
          ),
          aboutTeamAlias(),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Проект был выполнен студентами Мурманского Арктического "
                  "государственного университета в рамках дисциплин "
                  "\"Университетский проект\" и \"Проект направленности (профиля)\".",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      letterSpacing: 3),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              memberTeamField(
                  'lib/assets/Baginskii.jpg', 'Багинский Денис', 'Программист'),
              memberTeamField('lib/assets/Markova.jpg', 'Маркова Варвара',
                  'Программист, дизайнер'),
              memberTeamField(
                  'lib/assets/Projerin.jpg', 'Прожерин Дмитрий', 'Программист'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              memberTeamField(
                  'lib/assets/Surovets.jpg', 'Суровец Валерия', 'Биолог'),
              memberTeamField(
                  'lib/assets/Moiseeva.jpg', 'Моисеева Нина', 'Биолог'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              memberTeamField('lib/assets/Baginskii.jpg',
                  'Мирошников Владислав', 'Программист'),
              memberTeamField(
                  'lib/assets/Projerin.jpg', 'Андреев Матвей', 'Программист'),
            ],
          ),
        ],
      );
    }

    Widget mobileView() {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
        children: [
          Image.asset('lib/assets/logo.png', height: 252, width: 253),
          Flexible(
            child: Text(
                "\"Полярное солнце\" - это проект направленный"
                " на биоразнообразие мурманской области.",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 20),
                textAlign: TextAlign.center),
          ),
          Flexible(
            child: Text(
              "\nНа сайте размещён цифровой гербарий МАГУ,"
              " включающий коллекцию растений, произрастающих на территории"
              " Мурманской области и собранных исследователями нашего "
              "вуза во время экспедиций.",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
          aboutTeamAlias(),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Проект был выполнен студентами Мурманского Арктического "
                  "государственного университета в рамках дисциплин "
                  "\"Университетский проект\" и \"Проект направленности (профиля)\".",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              memberTeamMobileField(
                  'lib/assets/Baginskii.jpg', 'Багинский Денис', 'Программист'),
              memberTeamMobileField('lib/assets/Markova.jpg', 'Маркова Варвара',
                  'Программист, дизайнер'),
              memberTeamMobileField(
                  'lib/assets/Projerin.jpg', 'Прожерин Дмитрий', 'Программист'),
              memberTeamMobileField(
                  'lib/assets/Surovets.jpg', 'Суровец Валерия', 'Биолог'),
              memberTeamMobileField(
                  'lib/assets/Moiseeva.jpg', 'Моисеева Нина', 'Биолог'),
              memberTeamMobileField('lib/assets/Baginskii.jpg',
                  'Мирошников Владислав', 'Программист'),
              memberTeamMobileField(
                  'lib/assets/Projerin.jpg', 'Андреев Матвей', 'Программист'),
            ],
          ),
        ],
      );
    }

    return getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
        ? mobileView()
        : desktopView();
  }
}
