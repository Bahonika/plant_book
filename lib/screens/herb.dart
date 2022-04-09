import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/repositories/plant_repository.dart';
import '../views/plant_view.dart';

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

    Widget mobilePlant(Plant plant) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.primaryContainer),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlantView(plant: plant)));
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

    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: plants.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: mobilePlant(plants[i]),
          );
        });
  }
}
