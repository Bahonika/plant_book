import 'package:polar_sun/data/entities/family.dart';

import 'abstract/basic.dart';

class FamilyRepository extends BasicRepository<Family> {
  @override
  final String apiEndpoint = "event_info";

  @override
  Family fromJson(json) {
    return Family.fromJson(json);
  }
}
