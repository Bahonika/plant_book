import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/repositories/plant_repository.dart';

import '../buttons/plant_button.dart';

class Herb extends StatefulWidget {
  const Herb({Key? key}) : super(key: key);

  @override
  _HerbState createState() => _HerbState();
}

class _HerbState extends State<Herb> {
  List<Plant> plants = [];

  var repository = PlantRepository();
  final Map<String, String> queryParams = {};

  Future<void> getData(Map<String, String> queryParams) async {
    plants = await repository.getAll(queryParams: queryParams);
    setState(() {});
  }

  @override
  void initState() {
    getData(queryParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: plants.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: PlantButton(plants[i]),
              );
            }));
  }
}
