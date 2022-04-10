import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polar_sun/data/repositories/plant_repository.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

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
  File? photo;

  pickPhoto() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
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

    PlantRepository plantRepository = PlantRepository();

    addToDatabase() async {
      if (nameController.text == "" ||
          latinController.text == "" ||
          placeController.text == "" ||
          habitatController.text == "" ||
          collectorController.text == "" ||
          determinateController.text == "") {
        print("Заполните все поля");
      } else
        if (photo == null){
          print("Нет фото");
        }

    }

    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1, vertical: 20),
      children: [
        Center(
          child: Text("Добавление растения",
              style: GoogleFonts.montserrat(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: const Color.fromRGBO(14, 53, 23, 1),
                letterSpacing: 7,
              )),
        ),
        addTextField("Название", nameController),
        addTextField("Латинское название", latinController),
        addTextField("Место сбора", placeController),
        addTextField("Метообитание", habitatController),
        addTextField("Кто собрал", collectorController),
        addTextField("Кто определил", determinateController),
        DatePickerDialog(
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),

        ),
        ElevatedButton(
            onPressed: pickPhoto,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Выбрать изображение растения",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
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
      ],
    );
  }
}
