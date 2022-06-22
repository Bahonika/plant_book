import 'package:polar_sun/data/entities/abstract/displayable.dart';
import 'package:polar_sun/data/repositories/abstract/api.dart';
import 'package:polar_sun/utils/utf_8_convert.dart';

class Plant implements Displayable {
  final int id;
  final int serialNumber;
  final List<String> photoUrls;
  final String name;
  final String latin;
  final String family;
  final String? place;
  final String? habitat;
  final String? date;
  final String? collector;
  final String? determinate;

  Plant({
    required this.id,
    required this.serialNumber,
    required this.photoUrls,
    required this.name,
    required this.latin,
    required this.family,
    this.place,
    this.habitat,
    this.date,
    this.collector,
    this.determinate,
  });

  //aliases
  static const String serialAlias = "Номер";
  static const String nameAlias = "Название";
  static const String latinAlias = "Название на латыни";
  static const String familyAlias = "Семейство";
  static const String placeAlias = "Место сбора";
  static const String habitatAlias = "Местообитание";
  static const String dateAlias = "Дата сбора";
  static const String collectorAlias = "Собрал";
  static const String determinateAlias = "Определил";

  factory Plant.fromJson(Map<String, dynamic> json) {
    List<String> list = [];

    for (String photo in json["add_photos"]){
      list.add("https://" + Api.siteRoot + Api.apiRoot + photo.substring(1, photo.length));
    }

    return Plant(
      id: json["id"],
      serialNumber: json["serial_number"],
      photoUrls: list,
      name: utf8convert(json["name"]),
      latin: utf8convert(json["latin"]),
      family: utf8convert(json["family"]),
      place: utf8convert(json["place"]),
      habitat: utf8convert(json["habitat"]),
      date: utf8convert(json["date"]),
      collector: utf8convert(json["collector"]),
      determinate: utf8convert(json["determinate"]),
    );
  }

  @override
  Map<String, String> getFields() {
    return {
      Plant.serialAlias: serialNumber.toString(),
      Plant.nameAlias: name,
      Plant.latinAlias: latin,
      Plant.placeAlias: place!,
      Plant.habitatAlias: habitat!,
      Plant.familyAlias: family,
      Plant.dateAlias: date!,
      Plant.collectorAlias: collector!,
      Plant.determinateAlias: determinate!,
    };
  }
}
