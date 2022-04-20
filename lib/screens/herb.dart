import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/plant_repository.dart';
import 'package:polar_sun/utils/device_screen_type.dart';
import '../views/plant_view.dart';

class Herb extends StatefulWidget {
  final User user;

  const Herb({Key? key, required this.user}) : super(key: key);

  @override
  _HerbState createState() => _HerbState();
}

class _HerbState extends State<Herb> {
  // static Plant plant1 = Plant(
  //     id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  // static Plant plant2 = Plant(
  //     id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  // static Plant plant3 = Plant(
  //     id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  // static Plant plant4 = Plant(
  //     id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  // static Plant plant5 = Plant(
  //     id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  // static Plant plant6 = Plant(
  //     id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");
  // static Plant plant7 = Plant(
  //     id: 1, photo: 'lib/assets/80.jpg', name: "Имя", family: "Семейство");

  List<Plant> plants = [
    // plant1,
    // plant2,
    // plant3,
    // plant4,
    // plant5,
    // plant6,
    // plant7,
  ];

  var repository = PlantRepository();
  final Map<String, String> queryParams = {};

  Future<void> getData(Map<String, String> queryParams) async {
    // print(widget.user);
    // print(GuestUser());
    if (widget.user.role != GuestUser().role) {
      plants = await repository.getAll(
          queryParams: queryParams, user: widget.user as AuthorizedUser);
      setState(() {});
    }
  }

  @override
  void initState() {
    getData(queryParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget desktopPlant(Plant plant) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.90,
        width: MediaQuery.of(context).size.width * 0.30,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              primary: Color.fromRGBO(83, 165, 74, 0.8),
            ),
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
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      plant.photo_url,
                      height: MediaQuery.of(context).size.longestSide * 0.17,
                      width: MediaQuery.of(context).size.longestSide * 0.12,
                      fit: BoxFit.cover,
                    )),
                Text(
                  plant.name,
                  style: const TextStyle(fontSize: 24, color: Colors.white70),
                ),
                Text(
                  plant.latin,
                  style: const TextStyle(fontSize: 20, color: Colors.white54),
                ),
              ],
            )),
      );
    }

    Widget mobilePlant(Plant plant) {
      return Container(
        // height: MediaQuery.of(context).size.height * 0.3,
        // width: MediaQuery.of(context).size.width * 0.2,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              primary: Color.fromRGBO(83, 165, 74, 0.8),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlantView(plant: plant)));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      plant.photo_url,
                      width: MediaQuery.of(context).size.shortestSide * 0.17,
                      height: MediaQuery.of(context).size.shortestSide * 0.17,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          plant.name,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white70),
                        )),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          plant.latin,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white54),
                        )),
                  ],
                )
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
              horizontal: MediaQuery.of(context).size.width * 0.1),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: plants.length,
          itemBuilder: (BuildContext context, int i) {
            return desktopPlant(plants[i]);
          });
    }

    return widget.user.role == GuestUser().role
        ? const Center(
            child: Text("Для просмотра коллекции, пожалуйста, авторизируйтесь",
                style: TextStyle(
                    fontSize: 40,
                    color: Color.fromRGBO(12, 12, 12, 0.67),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 3),
            textAlign: TextAlign.center,),
          )
        : getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
            ? mobileView()
            : desktopView();
  }
}
