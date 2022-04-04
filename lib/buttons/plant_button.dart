import 'package:flutter/material.dart';
import 'package:polar_sun/views/plant_view.dart';

import '../data/entities/plant.dart';

class PlantButton extends StatelessWidget {
  final Plant plant;

  const PlantButton(this.plant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.primaryContainer
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PlantView(plant: plant)));
        },
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  plant.photo,
                  width: MediaQuery.of(context).size.width * 0.21,
                  height: MediaQuery.of(context).size.width * 0.21,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const Divider(),
            Text(plant.name, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
