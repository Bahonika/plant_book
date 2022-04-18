import 'dart:io';

import 'package:polar_sun/data/entities/abstract/postable.dart';

class PlantSave implements Postable {
  final int serialNumber;
  // final File photo;
  final String name;
  final String latin;
  final String family;
  final String? place;
  final String? habitat;
  final String? date;
  final String? collector;
  final String? determinate;

  PlantSave({
    required this.serialNumber,
    // required this.photo,
    required this.name,
    required this.latin,
    required this.family,
    this.place,
    this.habitat,
    this.date,
    this.collector,
    this.determinate,
  });

  @override
  Map<String, File> getFiles() {
    return {
      // 'photo': photo
    };
  }

  @override
  Map<String, dynamic> toJson() {
    var fields = {
      "serialNumber": serialNumber,
      "name": name,
      "latin": latin,
      "family": family,
      "place": place,
      "habitat": habitat,
      "date": date,
      "collector": collector,
      "determinate": determinate
    };
    return fields;
  }
}
