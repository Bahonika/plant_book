import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/auth_user.dart';
import 'package:polar_sun/screens/home_page.dart';
import 'package:polar_sun/screens/register_page.dart';
import 'package:polar_sun/templates/box_shadow.dart';
import 'package:polar_sun/utils/device_screen_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController passwordController;
  late TextEditingController loginController;

  User? user;
  var authUser = AuthUser();
  bool isAuthFailed = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    loginController = TextEditingController();
    super.initState();
  }

  void login() async {
    try {
      user = await authUser.auth(
          loginController.value.text, passwordController.value.text);
      var prefs = await SharedPreferences.getInstance();
      user?.save(prefs);
      setState(() {
        isAuthFailed = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WillPopScope(
                  onWillPop: () async => false, child: HomePage(user: user!))));
    } on AuthorizationException {
      setState(() {
        isAuthFailed = true;
      });
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthOfTextFields;
    widthOfTextFields =
        getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
            ? MediaQuery.of(context).size.width * 0.5
            : 400;

    Widget splash() {
      return SizedBox(
          width: MediaQuery.of(context).size.longestSide * 0.3,
          height: MediaQuery.of(context).size.longestSide * 0.3,
          child: Image.asset(
            'lib/assets/splash.png',
            fit: BoxFit.fitWidth,
          ));
    }

    Widget subscribeButton() {
      return SizedBox(
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 1),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(user: GuestUser()))),
          child: const Text(
            "Войти как гость",
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }

    Widget loginButton() {
      return SizedBox(
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 1),
            onPressed: () => login(),
            child: Text("Войти", style: GoogleFonts.montserrat(fontSize: 24)),
          ));
    }

    Widget loginTextField() {
      return Container(
          height: 46,
          width: widthOfTextFields,
          decoration: BoxDecoration(
              color: Colors.white60, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
              controller: loginController,
              decoration: const InputDecoration(
                hintText: "Логин",
                border: InputBorder.none,
              )));
    }

    Widget passwordTextField() {
      return Container(
          height: 46,
          width: widthOfTextFields,
          decoration: BoxDecoration(
              color: Colors.white60, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Пароль",
                border: InputBorder.none,
              )));
    }

    Widget authorizationAlias() {
      return Text("АВТОРИЗАЦИЯ",
          style: GoogleFonts.montserrat(
              fontSize: MediaQuery.of(context).size.longestSide * 0.025 < 28 ? 28 : MediaQuery.of(context).size.longestSide * 0.025,
              fontWeight: FontWeight.w700,
              letterSpacing: 10));
    }

    Widget registerButton(){
      return SizedBox(
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 1),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())),
            child: Text("Регистрация", style: GoogleFonts.montserrat(fontSize: 24)),
          ));
    }

    Widget mobileView() {
      return Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 390,
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      authorizationAlias(),
                      loginTextField(),
                      passwordTextField(),
                      loginButton(),
                      subscribeButton(),
                    ])),
            const SizedBox(
              width: 20,
            ),
            splash(),
          ]),
        ),
      );
    }

    Widget desktopView() {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                height: 390,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      authorizationAlias(),
                      loginTextField(),
                      passwordTextField(),
                      SizedBox(
                        width: widthOfTextFields,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [loginButton(), subscribeButton()],
                        ),
                      ),
                      registerButton()
                    ])),
            const SizedBox(
              width: 20,
            ),
            splash()
          ],
        ),
      );
    }

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(boxShadow: boxShadow(context)),
      child: getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
          ? mobileView()
          : desktopView(),
    ));
  }
}
