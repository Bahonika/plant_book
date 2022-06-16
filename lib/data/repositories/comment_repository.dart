import 'package:polar_sun/data/entities/comment.dart';
import 'package:polar_sun/data/repositories/abstract/basic.dart';

class CommentRepository extends BasicRepository<Comment>{

  @override
  String get apiEndpoint => "comment";

  @override
  Comment fromJson(json) {
    return Comment.fromJson(json);
  }
}
