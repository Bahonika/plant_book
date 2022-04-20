import 'package:polar_sun/data/entities/plant_save.dart';
import 'package:polar_sun/data/repositories/abstract/post_update_repisitory.dart';
import 'package:polar_sun/data/repositories/abstract/multipart_repository.dart';

class PlantSaveRepository extends MultipartRepository<PlantSave> {
  @override
  final String apiEndpoint = "plant";

  @override
  final String idAlias = "id";

  @override
  PlantSave fromJson(json) {
    throw UnimplementedError();
  }
}
