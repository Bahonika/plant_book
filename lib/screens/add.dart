import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/entities/plant_save.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/plant_save_repository.dart';

class Add extends StatefulWidget {
  const Add({Key? key, required this.user}) : super(key: key);

  final AuthorizedUser user;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController nameController = TextEditingController();
  TextEditingController latinController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController habitatController = TextEditingController();
  TextEditingController collectorController = TextEditingController();
  TextEditingController determinateController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  File? photo;

  DateTime selectedDate = DateTime.now();

  pickPhoto() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        photo = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    addTextField(String text, TextEditingController textEditingController) {
      return Container(
        width: 600,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            label: Text(text),
            border: InputBorder.none,
          ),
        ),
      );
    }

    selectDate(BuildContext context) async {
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

    PlantSaveRepository plantSaveRepository = PlantSaveRepository();

    addToDatabase() async {
      if (nameController.text == "" ||
          latinController.text == "" ||
          placeController.text == "" ||
          habitatController.text == "" ||
          collectorController.text == "" ||
          determinateController.text == "") {
        print("Заполните все поля");
      } else if (photo == null) {
        print("Нет фото");
      } else {
        PlantSave plantSave = PlantSave(
          serialNumber: int.parse(serialController.text),
          name: nameController.text,
          photo: File(photo!.path),
          latin: latinController.text,
          family: placeController.text,
          collector: collectorController.text,
          date: DateFormat("yyyy-MM-dd").format(selectedDate).toString(),
          determinate: determinateController.text,
          habitat: habitatController.text,
          place: placeController.text,
        );
        plantSaveRepository.create(plantSave, widget.user);
      }
    }

    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 20),
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
        addTextField(Plant.serialAlias, serialController),
        addTextField(Plant.nameAlias, nameController),
        addTextField(Plant.latinAlias, latinController),
        addTextField(Plant.placeAlias, placeController),
        addTextField(Plant.habitatAlias, habitatController),
        addTextField(Plant.collectorAlias, collectorController),
        addTextField(Plant.determinateAlias, determinateController),
        ElevatedButton(
          onPressed: () => selectDate(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Выбрать дату сбора - " +
                  DateFormat("dd.MM.yyyy").format(selectedDate),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).backgroundColor),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: pickPhoto,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Выбрать изображение растения",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).backgroundColor),
              ),
            )),
        photo != null
            ? kIsWeb
                ? Text(
                    "Выбран файл " + photo!.path,
                    style: const TextStyle(fontSize: 15),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Image.file(
                      photo!,
                      fit: BoxFit.cover,
                    ),
                  )
            : const SizedBox(
                height: 20,
              ),
        ElevatedButton(
            onPressed: addToDatabase,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Готово",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).backgroundColor),
              ),
            )),
      ],
    );
  }
}
