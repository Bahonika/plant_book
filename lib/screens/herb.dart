import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:polar_sun/data/entities/family.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/family_repository.dart';
import 'package:polar_sun/data/repositories/plant_repository.dart';
import 'package:polar_sun/templates/decorators.dart';
import 'package:polar_sun/utils/device_screen_type.dart';
import '../views/plant_view.dart';

class Herb extends StatefulWidget {
  final User user;

  const Herb({Key? key, required this.user}) : super(key: key);

  @override
  _HerbState createState() => _HerbState();
}

class _HerbState extends State<Herb> {
  List<Plant> plants = [];

  PlantRepository plantRepository = PlantRepository();
  final Map<String, String> queryParams = {};

  Future<void> getData(Map<String, String> queryParams) async {
    if (widget.user.toString() != GuestUser().role) {
      plants = await plantRepository.getAll(
          queryParams: queryParams, user: widget.user as AuthorizedUser);
    }
    setState(() {});
  }

  Family? selectedFamily;
  List<Family> familys = [];
  FamilyRepository familyRepository = FamilyRepository();

  void getFamilys() async {
    familys = await familyRepository.getAll(
      queryParams: queryParams,
      user: widget.user as AuthorizedUser,
    );
  }

  SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();
  TextEditingController selectedFamilyController = TextEditingController();

  Widget familyTypeAheadField() {
    return Container(
      decoration: textBoxDecoration,
      child: TypeAheadField(
          suggestionsBoxController: suggestionsBoxController,
          textFieldConfiguration: TextFieldConfiguration(
            decoration: inputDecoration("Начните вводить название").copyWith(
              suffixIcon: IconButton(
                  onPressed: () {
                    selectedFamilyController.text = "";
                    queryParams.clear();
                    getData(queryParams);
                  },
                  icon: Icon(Icons.close)),
            ),
            controller: selectedFamilyController,
          ),
          suggestionsCallback: (pattern) =>
              familys.where((element) => element.familyName.contains(pattern)),
          itemBuilder: (context, Family suggestion) {
            return ListTile(
              leading: Text(suggestion.familyName),
              focusColor: Theme.of(context).colorScheme.primary,
              tileColor: Colors.white,
            );
          },
          onSuggestionSelected: (Family family) {
            selectedFamily = family;
            selectedFamilyController.text = selectedFamily!.familyName;
            queryParams.addAll({"family": selectedFamily!.id.toString()});
            getData(queryParams);
            setState(() {});
          }),
    );
  }

  @override
  void initState() {
    getData(queryParams);
    getFamilys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget desktopPlant(Plant plant) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.90,
        width: MediaQuery.of(context).size.width * 0.30,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              primary: const Color.fromRGBO(83, 165, 74, 0.8),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlantView(
                          plant: plant, user: widget.user as AuthorizedUser)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    plant.photoUrls[0]
                            .substring(0, plant.photoUrls[0].length - 4) +
                        "s.jpg",
                    height: MediaQuery.of(context).size.longestSide * 0.17,
                    width: MediaQuery.of(context).size.longestSide * 0.12,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  plant.name,
                  style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.longestSide * 0.0125,
                      color: Colors.white70),
                ),
                Text(
                  plant.latin,
                  style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.longestSide * 0.0104,
                      color: Colors.white54),
                ),
              ],
            )),
      );
    }

    Widget mobilePlant(Plant plant) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              primary: const Color.fromRGBO(83, 165, 74, 0.8),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlantView(
                          plant: plant, user: widget.user as AuthorizedUser)));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      plant.photoUrls[0]
                              .substring(0, plant.photoUrls[0].length - 4) +
                          "s.jpg",
                      width: MediaQuery.of(context).size.shortestSide * 0.18,
                      height: MediaQuery.of(context).size.shortestSide * 0.18,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          plant.name,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide *
                                      0.033,
                              color: Colors.white70),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          plant.latin,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide *
                                      0.028,
                              color: Colors.white54),
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
      return Stack(
        children: [
          GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: plants.length,
              itemBuilder: (BuildContext context, int i) {
                return desktopPlant(plants[i]);
              }),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 300,
                decoration: textBoxDecoration,
                child: familyTypeAheadField(),
              )),
        ],
      );
    }

    return widget.user.toString() == GuestUser().role
        ? const Center(
            child: Text(
              "Для просмотра коллекции, пожалуйста, авторизируйтесь",
              style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(12, 12, 12, 0.67),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 3),
              textAlign: TextAlign.center,
            ),
          )
        : getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
            ? mobileView()
            : desktopView();
  }
}
