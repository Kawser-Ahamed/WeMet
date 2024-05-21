import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/comment/data/datasource/comment_datasource.dart';
import 'package:wemet/features/comment/data/model/comment_model.dart';
import 'package:wemet/features/comment/domain/entities/comment_entities.dart';
import 'package:wemet/features/comment/domain/repositories/comment_repository.dart';

class CommentRepositoryImplementation implements CommentRepository{
  
  CommentDataSource commentDataSource;
  CommentRepositoryImplementation(this.commentDataSource);

  @override
  Future<Either<Failure, String>> uploadComment(CommentEntities commentEntities) async{
    try{
      CommentModel commentModel = CommentModel(
        id: commentEntities.id.toString(), 
        comment: commentEntities.comment, 
        dateTime: commentEntities.dateTime,
        commenterName: commentEntities.commenterName, 
        email: commentEntities.email, 
        commenterProfilePictureImageUrl: commentEntities.commenterProfilePictureImageUrl,
      );
      final response = await commentDataSource.uploadComment(commentModel);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<CommentEntities>>> fetchComment(int id) async{
    try{
      final response = await commentDataSource.fetchComment(id);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }

  }


}