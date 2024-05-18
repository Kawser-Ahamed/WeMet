import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/comment/domain/entities/comment_entities.dart';

abstract interface class CommentRepository{

  Future<Either<Failure,String>> uploadComment(CommentEntities commentEntities);
  Future<Either<Failure,List<CommentEntities>>> fetchComment(int id);
  
}