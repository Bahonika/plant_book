import 'dart:io';

import 'package:polar_sun/data/entities/abstract/postable.dart';

class PlantSave implements PostableWithMultipart {
  final int serialNumber;
  final List<int> photoIds;
  final String name;
  final String latin;
  final int family;
  final String? place;
  final String? habitat;
  final String? date;
  final String? collector;
  final String? determinate;

  PlantSave({
    required this.serialNumber,
    required this.photoIds,
    required this.name,
    required this.latin,
    required this.family,
    required this.place,
    required this.date,
    this.habitat,
    this.collector,
    this.determinate,
  });

  @override
  Map<String, File> getFiles() {
    return {};
  }

  @override
  Map<String, dynamic> toJson() {
    var fields = {
      "serial_number": serialNumber,
      "name": name,
      "latin": latin,
      "family": family,
      "add_photos": photoIds,
      "place": place,
      "habitat": habitat,
      "date": date,
      "collector": collector,
      "determinate": determinate
    };
    return fields;
  }
}
