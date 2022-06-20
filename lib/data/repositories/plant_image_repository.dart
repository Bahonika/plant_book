import 'package:polar_sun/data/entities/plant_image.dart';
import 'package:polar_sun/data/repositories/abstract/multipart_repository.dart';

class PlantImageRepository extends MultipartRepository<PlantImage> {
  @override
  final String apiEndpoint = "plant_image";

  @override
  String idAlias = "id";

  @override
  PlantImage fromJson(json) {
    throw UnimplementedError();
  }
}
