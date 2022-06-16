import 'package:polar_sun/data/entities/abstract/displayable.dart';

import '../../utils/utf_8_convert.dart';

class Comment implements Displayable {
  final int id;
  final String text;
  final int user;
  final int plant;

  Comment({
    required this.id,
    required this.text,
    required this.user,
    required this.plant,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json["id"],
        user: json["user"],
        plant: json["plant"],
        text: utf8convert(json["text"]));
  }

  @override
  Map<String, String> getFields() {
    return {
      "Пользователь": user.toString(),
      "Текст": text,
      "Растение": plant.toString()
    };
  }
}
