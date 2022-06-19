import 'dart:io';

import 'package:polar_sun/data/entities/abstract/postable.dart';


class PlantImage implements PostableWithMultipart{
  final File photo;

  PlantImage(this.photo);

  @override
  Map<String, File> getFiles() {
    return {
      'photo': photo
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}