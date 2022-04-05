import 'package:flutter/material.dart';
import 'package:polar_sun/screens/home_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Вход"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 390,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("а в т о р и з а ц и я",
                    style: TextStyle(fontSize: 50)),
                Container(
                  height: 46,
                  width: 390,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Логин", style: TextStyle(fontSize: 24),),
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
                      label: Text("Пароль", style: TextStyle(fontSize: 24),),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 390,
                  child: Row(
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
                          child: const Text("Войти", style: TextStyle(
                              fontSize: 24),
                        ),
                        )
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
                                  builder: (context) => HomePage())),
                          child: const Text("Войти как гость", style: TextStyle(
                            fontSize: 24
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
