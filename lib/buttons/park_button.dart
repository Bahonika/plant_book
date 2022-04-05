import 'package:flutter/material.dart';
import 'package:polar_sun/views/park_view.dart';

import '../data/entities/park.dart';

class ParkButton extends StatelessWidget {
  final Park park;

  const ParkButton(this.park, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.primaryContainer),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ParkView(park: park)));
        },
        child: Text(
          park.parkName,
        ),
      ),
    );
  }
}
