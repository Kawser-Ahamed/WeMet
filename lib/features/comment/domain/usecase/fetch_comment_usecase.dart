import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/comment/domain/entities/comment_entities.dart';
import 'package:wemet/features/comment/domain/repositories/comment_repository.dart';

class FetchCommentUsecase implements UseCase<List<CommentEntities>,FetchCommentParams>{
  
  CommentRepository commentRepository;
  FetchCommentUsecase(this.commentRepository);

  @override
  Future<Either<Failure, List<CommentEntities>>> call(FetchCommentParams params) async{
    return await commentRepository.fetchComment(params.id);
  }
}

class FetchCommentParams{

  final int id;
  FetchCommentParams({required this.id});

}