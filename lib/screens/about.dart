import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "О нас",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('lib/assets/masu.png'),
              const Text(
                "Проект создан в рамках дисциплины "
                    "\"Университетский проект\" командой "
                    "студентов 2ПМИ и 2БИО \nПочта для"
                    " связи: Bahonika@mail.ru",
              ),
            ],
          ),
        ));
  }
}
