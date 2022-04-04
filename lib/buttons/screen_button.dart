import 'package:flutter/material.dart';

class ScreenButton extends StatelessWidget {
  final String name;
  final Widget widget;
  final String image;

  ScreenButton(this.name, this.image, this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.primaryContainer
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget));
        },
        child: Row(
          children: [
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.21,
              height: MediaQuery.of(context).size.width * 0.21,
            ),
            Text(
              name,
            ),
          ],
        ),
      ),
    );
  }
}
