import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/comment/domain/entities/comment_entities.dart';
import 'package:wemet/features/comment/domain/repositories/comment_repository.dart';

class UploadCommentUsecase implements UseCase<String,CommentEntities>{
  
  CommentRepository commentRepository;
  UploadCommentUsecase(this.commentRepository);

  @override
  Future<Either<Failure, String>> call(CommentEntities params) async{
    return await commentRepository.uploadComment(params);
  }
}