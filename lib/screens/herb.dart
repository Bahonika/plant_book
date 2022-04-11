import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/repositories/plant_repository.dart';
import 'package:polar_sun/utils/device_screen_type.dart';
import '../views/plant_view.dart';

class Herb extends StatefulWidget {
  const Herb({Key? key}) : super(key: key);

  @override
  _HerbState createState() => _HerbState();
}

class _HerbState extends State<Herb> {
  static Plant plant1 = Plant(
      id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  static Plant plant2 = Plant(
      id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  static Plant plant3 = Plant(
      id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  static Plant plant4 = Plant(
      id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  static Plant plant5 = Plant(
      id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  static Plant plant6 = Plant(
      id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  static Plant plant7 = Plant(
      id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");

  List<Plant> plants = [
    plant1,
    plant2,
    plant3,
    plant4,
    plant5,
    plant6,
    plant7,
  ];

  var repository = PlantRepository();
  final Map<String, String> queryParams = {};

  Future<void> getData(Map<String, String> queryParams) async {
    plants = await repository.getAll(queryParams: queryParams);
    setState(() {});
  }

  @override
  void initState() {
    // getData(queryParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget desktopPlant(Plant plant) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.15,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlantView(plant: plant)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      plant.photo,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.15,
                      fit: BoxFit.fitHeight,
                    )),
                Text(
                  plant.name,
                  style: const TextStyle(fontSize: 20, color: Colors.white60),
                )
              ],
            )),
      );
    }

    Widget mobilePlant(Plant plant) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlantView(plant: plant)));
            },
            child: Row(
              children: [
                Image.asset(
                  plant.photo,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.25,
                  fit: BoxFit.fitWidth,
                ),
                Text(plant.name)
              ],
            )),
      );
    }

    Widget mobileView() {
      return ListView.builder(
          itemCount: plants.length,
          itemBuilder: (BuildContext context, int i) {
            return mobilePlant(plants[i]);
          });
    }

    Widget desktopView() {
      return GridView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: plants.length,
          itemBuilder: (BuildContext context, int i) {
            return desktopPlant(plants[i]);
          });
    }

    return getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
        ? mobileView()
        : desktopView();
  }
}
