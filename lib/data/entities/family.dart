import 'package:polar_sun/data/entities/abstract/displayable.dart';
import 'package:polar_sun/utils/utf_8_convert.dart';

class Family implements Displayable {
  final int id;
  final String familyName;

  Family({required this.id, required this.familyName});

  static const familyNameAlias = "Семейство";

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
        id: json['id'] as int, familyName: utf8convert(json['family_name']));
  }
  @override
  Map<String, String> getFields() {
    return {
      Family.familyNameAlias: familyName,
    };
  }
}
