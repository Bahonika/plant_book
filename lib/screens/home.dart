import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double elevation = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Полярное солнце",
              style: GoogleFonts.montserratAlternates(
                fontSize: 110,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text("Биоразнообразие северной природы",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 36,
                    letterSpacing: 7)),
            SizedBox(
              height: 93,
            ),
            Container(
              height: 143,
              width: 577,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primaryContainer,
                      elevation: elevation),
                  onHover: (bool isHover) {
                    isHover ? elevation = 10 : elevation = 1;
                    setState(() {});
                  },
                  onPressed: () {
                    print("hello");
                  },
                  child: Row(
                    children: [
                      Image.asset('lib/assets/herbarium.png'),
                      const Text("Цифровой гербарий МАГУ",
                          style: TextStyle(fontSize: 16))
                    ],
                  )),
            ),
            const SizedBox(
              height: 36,
            ),
            Container(
              height: 143,
              width: 577,
              child: ElevatedButton(
                  onPressed: null,
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/assets/flora.png',
                        height: 92,
                        width: 133,
                      ),
                      Text("Заповедники и ботанические сады")
                    ],
                  )),
            ),
          ],
        )
      ],
    );
  }
}
