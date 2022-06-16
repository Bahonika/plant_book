import 'package:polar_sun/data/entities/abstract/postable.dart';

class CommentSave implements Postable {

  final String text;
  final int user;
  final int plant;

  CommentSave(
      {
      required this.text,
      required this.user,
      required this.plant});

  @override
  Map<String, dynamic> toJson() {
    var fields = {
      "text": text,
      "user": user,
      "plant": plant,
    };
    return fields;
  }
}
