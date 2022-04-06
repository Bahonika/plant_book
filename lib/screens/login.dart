import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar_sun/screens/home_page.dart';
import 'package:polar_sun/utils/device_screen_type.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Container(
        height: 390,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment:
              getDeviceType(MediaQuery.of(context)) == DeviceScreenType.desktop
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("АВТОРИЗАЦИЯ",
                style: GoogleFonts.montserrat(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 10)),
            Container(
              height: 46,
              width: 390,
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Логин",
                    style: TextStyle(fontSize: 24),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: 390,
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Пароль",
                    style: TextStyle(fontSize: 24),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              width: 390,
              child: getDeviceType(MediaQuery.of(context)) ==
                      DeviceScreenType.mobile
                  ? Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 1),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage())),
                              child: const Text(
                                "Войти",
                                style: TextStyle(fontSize: 24),
                              ),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 1),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage())),
                            child: const Text(
                              "Оформить подписку",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 1),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage())),
                              child: const Text(
                                "Войти",
                                style: TextStyle(fontSize: 24),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 1),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage())),
                            child: const Text(
                              "Оформить подписку",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      SizedBox(
          height:
              getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
                  ? 300
                  : 600,
          child: Image.asset(
            'lib/assets/splash.png',
            fit: BoxFit.fitHeight,
          ))
    ];

    return getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets)
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
          );
  }
}
