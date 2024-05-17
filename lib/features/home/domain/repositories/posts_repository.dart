import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/home/domain/entities/posts_entities.dart';

abstract interface class PostsRepository{
  Future<Either<Failure,List<PostsEntities>>> getPosts();
}