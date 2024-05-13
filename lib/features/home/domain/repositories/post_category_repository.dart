import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/home/domain/entities/post_category_entities.dart';

abstract interface class PostCategoryrepository{
  Future<Either<Failure,List<PostCategoryEntities>>> getPostCategory();
}