import 'package:polar_sun/data/entities/comment_save.dart';
import 'package:polar_sun/data/repositories/abstract/post_update_repisitory.dart';

class CommentSaveRepository extends PostUpdateRepository<CommentSave> {
  @override
  String get apiEndpoint => "comment";

  @override
  CommentSave fromJson(json) {
    throw UnimplementedError();
  }

  @override
  String get idAlias => "id";
}
