import 'package:polar_sun/data/entities/family_save.dart';
import 'package:polar_sun/data/repositories/abstract/post_update_repisitory.dart';

class FamilySaveRepository extends PostUpdateRepository<FamilySave>{

  @override
  final String apiEndpoint = "family";

  @override
  FamilySave fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";

}