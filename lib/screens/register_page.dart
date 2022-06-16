import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/auth_user.dart';
import 'package:polar_sun/data/repositories/register.dart';
import 'package:polar_sun/templates/box_shadow.dart';
import 'package:polar_sun/utils/device_screen_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

String usernameError = "";
String emailError = "";
String passwordError = "";

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController passwordController;
  late TextEditingController usernameController;
  late TextEditingController firstController;
  late TextEditingController emailController;
  late TextEditingController lastController;

  User? user;
  var authUser = AuthUser();
  bool isAuthFailed = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    firstController = TextEditingController();
    emailController = TextEditingController();
    lastController = TextEditingController();

    usernameError = "";
    emailError = "";
    passwordError = "";

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    lastController.dispose();
    emailController.dispose();
    firstController.dispose();
    usernameController.dispose();
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

    Widget registryTextField(TextEditingController textEditingController,
        String text, TextInputType textInputType) {
      return Container(
          height: 46,
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: widthOfTextFields,
          decoration: BoxDecoration(
              color: Colors.white60, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
              keyboardType: textInputType,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: text,
                border: InputBorder.none,
              )));
    }

    Widget registarionAlias() {
      return Text("РЕГИСТРАЦИЯ",
          style: GoogleFonts.montserrat(
              fontSize: MediaQuery.of(context).size.longestSide * 0.025 < 28
                  ? 28
                  : MediaQuery.of(context).size.longestSide * 0.025,
              fontWeight: FontWeight.w700,
              letterSpacing: 10));
    }

    var registerUser = RegisterUser();

    void register() async {
      //TODO Сделать нормально, без костылей
      usernameError = " ";
      emailError = " ";
      passwordError = " ";
      registerUser.register(usernameController.text, firstController.text,
          lastController.text, emailController.text, passwordController.text);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }

    Widget registerButton() {
      return SizedBox(
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 1),
            onPressed: () => register(),
            child: Text("Зарегистрироваться",
                style: GoogleFonts.montserrat(fontSize: 24)),
          ));
    }

    Widget authorizationButton() {
      return SizedBox(
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 1),
            onPressed: () => Navigator.pop(context),
            child: Text("Войти",
                style: GoogleFonts.montserrat(fontSize: 24)),
          ));
    }

    Widget errorWidget(String error) {
      return error.length > 2
          ? Text(
              error,
              style: const TextStyle(color: Colors.redAccent),
            )
          : const SizedBox();
    }

    Widget mobileView() {
      return Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 500,
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      registarionAlias(),
                      registryTextField(
                          usernameController, "Никнейм*", TextInputType.name),
                      errorWidget(usernameError),
                      registryTextField(
                          firstController, "Имя", TextInputType.name),
                      registryTextField(
                          lastController, "Фамилия", TextInputType.name),
                      registryTextField(emailController, "Email*",
                          TextInputType.emailAddress),
                      errorWidget(emailError),
                      registryTextField(passwordController, "Пароль*",
                          TextInputType.visiblePassword),
                      errorWidget(passwordError),
                      registerButton(),
                      authorizationButton()
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
                height: 500,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      registarionAlias(),
                      registryTextField(
                          usernameController, "Никнейм*", TextInputType.name),
                      errorWidget(usernameError),
                      registryTextField(
                          firstController, "Имя", TextInputType.name),
                      registryTextField(
                          lastController, "Фамилия", TextInputType.name),
                      registryTextField(
                          emailController, "Email*", TextInputType.emailAddress),
                      errorWidget(emailError),
                      registryTextField(passwordController, "Пароль*",
                          TextInputType.visiblePassword),
                      errorWidget(passwordError),
                      registerButton(),
                      authorizationButton()
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
