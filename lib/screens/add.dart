import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:polar_sun/data/entities/family.dart';
import 'package:polar_sun/data/entities/family_save.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/entities/plant_image.dart';
import 'package:polar_sun/data/entities/plant_save.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/family_repository.dart';
import 'package:polar_sun/data/repositories/family_save_repository.dart';
import 'package:polar_sun/data/repositories/plant_image_repository.dart';
import 'package:polar_sun/data/repositories/plant_save_repository.dart';
import 'package:polar_sun/templates/decorators.dart';

class Add extends StatefulWidget {
  const Add({Key? key, required this.user}) : super(key: key);

  final AuthorizedUser user;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  //TODO изменить функцию добавления растения
  TextEditingController nameController = TextEditingController();
  TextEditingController latinController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController habitatController = TextEditingController();
  TextEditingController selectedFamilyController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController collectorController = TextEditingController();
  TextEditingController determinateController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  File? mainPhoto;
  List<File> addPhotos = [];

  List<Family> familys = [];

  FamilySaveRepository familySaveRepository = FamilySaveRepository();
  PlantSaveRepository plantSaveRepository = PlantSaveRepository();

  String errorText = "";

  DateTime selectedDate = DateTime.now();

  FamilyRepository familyRepository = FamilyRepository();
  final Map<String, String> queryParams = {};

  Family? selectedFamily;

  void getFamilys() async {
    familys = await familyRepository.getAll(
      queryParams: queryParams,
      user: widget.user,
    );
  }

  void pickPhoto() async {
    XFile? pickedFile;
    if (!kIsWeb) {
      if (Platform.isWindows) {
        final typeGroup =
            XTypeGroup(label: 'images', extensions: ['jpg', 'png']);
        pickedFile = await openFile(acceptedTypeGroups: [typeGroup]);
      } else {
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
      }
    } else {
      pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (pickedFile != null) {
      setState(() {
        mainPhoto = File(pickedFile!.path);
        addPhotos.insert(0, mainPhoto!);
      });
    }
  }

  void pickAddPhotos() async {
    List<XFile>? pickedFiles;
    if (!kIsWeb) {
      if (Platform.isWindows) {
        final XTypeGroup jpgsTypeGroup = XTypeGroup(
          label: 'JPEGs',
          extensions: <String>['jpg', 'jpeg'],
        );
        final XTypeGroup pngTypeGroup = XTypeGroup(
          label: 'PNGs',
          extensions: <String>['png'],
        );
        pickedFiles = await openFiles(acceptedTypeGroups: <XTypeGroup>[
          jpgsTypeGroup,
          pngTypeGroup,
        ]);
      } else {
        pickedFiles = await ImagePicker().pickMultiImage();
      }
    } else {
      pickedFiles = await ImagePicker().pickMultiImage();
    }
    if (pickedFiles != null) {
      setState(() {
        if (addPhotos.isNotEmpty) {
          addPhotos.removeRange(1, addPhotos.length);
        }
        for (XFile xFile in pickedFiles!) {
          addPhotos.add(File(xFile.path));
        }
      });
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    getFamilys();
    super.initState();
  }

  bool validation() {
    if (nameController.text == "" ||
        latinController.text == "" ||
        (familyController.text == "" && selectedFamily == null)) {
      errorText = "Заполните все обязательные поля";
      return false;
    } else if (addPhotos.isEmpty || mainPhoto == null) {
      errorText = "Добавьте фотографию";
      return false;
    } else {
      return true;
    }
  }

  int familyId = -1;

  familyAddToDatabase() async {
    if (familyController.text != "") {
      FamilySave familySave = FamilySave(familyName: familyController.text);
      familyId = await familySaveRepository.create(familySave, widget.user);
    } else if (selectedFamily != null) {
      familyId = selectedFamily!.id;
    }
  }

  PlantImageRepository plantImageRepository = PlantImageRepository();

  List<int> photoIds = [];

  imagesAddToDatabase() async {
    if (addPhotos.isNotEmpty) {
      for (int i = 0; i < addPhotos.length; i++) {
        int id = await plantImageRepository.create(
            PlantImage(File(addPhotos[i].path)), widget.user);
        photoIds.add(id);
      }
    }
  }

  plantAddToDatabase() {
    PlantSave plantSave = PlantSave(
      serialNumber: int.parse(serialController.text),
      name: nameController.text,
      photoIds: photoIds,
      latin: latinController.text,
      family: familyId,
      collector: collectorController.text,
      date: DateFormat("yyyy-MM-dd").format(selectedDate).toString(),
      determinate: determinateController.text,
      habitat: habitatController.text,
      place: currentDistrict,
    );
    plantSaveRepository.create(plantSave, widget.user);
  }

  listsClear() {
    print(photoIds);
    print(addPhotos);
    addPhotos.clear();
    photoIds.clear();
    print("Обнуление");
    print(photoIds);
    print(addPhotos);
  }

  addToDatabase() async {
    if (validation()) {
      await familyAddToDatabase();
      await imagesAddToDatabase();
      await plantAddToDatabase();
      listsClear();
      errorText = "Успех";
    }
    setState(() {});
  }

  addTextField(String text, TextEditingController textEditingController) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: textBoxDecoration,
      child: TextFormField(
          controller: textEditingController, decoration: inputDecoration(text)),
    );
  }

  List<String> districts = [
    "Неизвестно",
    'Кандалакшский район',
    'Ковдорский район',
    'Кольский район',
    'Ловозерский район',
    'Печенгский район',
    'Терский район',
  ];

  String currentDistrict = "Неизвестно";

  SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();

  @override
  Widget build(BuildContext context) {
    Widget familyTypeAheadField() {
      return Container(
        decoration: textBoxDecoration,
        child: TypeAheadField(
            suggestionsBoxController: suggestionsBoxController,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: inputDecoration("Начните вводить название"),
              controller: selectedFamilyController,
            ),
            suggestionsCallback: (pattern) => familys
                .where((element) => element.familyName.contains(pattern)),
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
            }),
      );
    }

    Widget serialNumberTextField = Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: textBoxDecoration,
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          keyboardType: TextInputType.number,
          decoration: inputDecoration(Plant.serialAlias + '*'),
          controller: serialController,
        ));

    return kIsWeb
        ? const Center(
            child: Text(
              "Добавление новых экземпляров с браузера временно недоступно. \nВоспользуйтесь мобильным или настольным приложением",
              style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(12, 12, 12, 0.67),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 3),
              textAlign: TextAlign.center,
            ),
          )
        : ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: 20),
            children: [
              Center(
                child: Text("Добавление растения",
                    style: GoogleFonts.montserrat(
                      fontSize: MediaQuery.of(context).size.longestSide * 0.025,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(14, 53, 23, 1),
                      letterSpacing: 7,
                    )),
              ),
              serialNumberTextField,
              addTextField(Plant.nameAlias + '*', nameController),
              addTextField(Plant.latinAlias + '*', latinController),
              Container(
                decoration: textBoxDecoration,
                child: DropdownButton<String>(
                  value: currentDistrict,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      currentDistrict = newValue!;
                    });
                  },
                  dropdownColor: Colors.white,
                  items:
                      districts.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Выберите семейство из списка",
                            style: TextStyle(fontSize: 20),
                          ),
                          familyTypeAheadField(),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(" "),
                      Text(
                        "или*",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Добавьте новое семейство",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            decoration: textBoxDecoration,
                            child: TextField(
                              controller: familyController,
                              decoration: inputDecoration("Семейство"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              addTextField(Plant.habitatAlias, habitatController),
              addTextField(Plant.collectorAlias, collectorController),
              addTextField(Plant.determinateAlias, determinateController),
              ElevatedButton(
                onPressed: () => selectDate(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Выбрать дату сбора* - " +
                        DateFormat("dd.MM.yyyy").format(selectedDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).backgroundColor),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                    onPressed: pickPhoto,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Выбрать изображение растения*",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).backgroundColor),
                      ),
                    )),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: pickAddPhotos,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Выбрать дополнительные изображения",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).backgroundColor),
                      ),
                    )),
              ),
              Visibility(
                  visible: addPhotos.isNotEmpty,
                  child: Container(
                    height: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemCount: addPhotos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                height: 200,
                                width: 100,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 4),
                                ),
                                child: Image.file(addPhotos[index],
                                    fit: BoxFit.cover),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () => setState(() {
                                          addPhotos.removeAt(index);
                                        }),
                                    iconSize: 20,
                                    icon: const Icon(Icons.close)),
                              )
                            ],
                          );
                        }),
                  )),
              Text(
                errorText,
                style: const TextStyle(color: Colors.redAccent, fontSize: 25),
              ),
              ElevatedButton(
                  onPressed: addToDatabase,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Готово",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).backgroundColor),
                    ),
                  )),
            ],
          );
  }
}
