import 'package:flutter/material.dart';
import 'package:footer/footer.dart';

Footer footer(BuildContext context){
  return Footer(
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 65,
          child: Image.asset('lib/assets/masu-logo.png'),
        ),
        const Text("с 2022 Полярное солнце"),
        Container(
          color: Colors.white70,
          height: 50,
          width: 50,
        ),
      ],
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
  );
}