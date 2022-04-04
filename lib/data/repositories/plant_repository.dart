

import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/repositories/abstract/basic.dart';

class PlantRepository extends BasicRepository<Plant>{

  @override
  final String apiEndpoint = "plant/";

  @override
  Plant fromJson(json) {
    return Plant.fromJson(json);
  }
}