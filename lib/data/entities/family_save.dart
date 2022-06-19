import 'package:polar_sun/data/entities/abstract/postable.dart';

class FamilySave implements Postable {
  final String familyName;

  FamilySave({required this.familyName});

  @override
  Map<String, dynamic> toJson() {
    var map = {
      'family_name': familyName,
    };

    return map;
  }
}
