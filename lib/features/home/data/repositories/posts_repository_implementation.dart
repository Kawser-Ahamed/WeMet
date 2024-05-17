import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/home/data/datasource/posts_datasource.dart';
import 'package:wemet/features/home/data/model/posts_model.dart';
import 'package:wemet/features/home/domain/repositories/posts_repository.dart';

class PostsRepositoryImplementation implements PostsRepository{
  
  PostsDatasource postsDatasource;
  PostsRepositoryImplementation(this.postsDatasource);

  @override
  Future<Either<Failure, List<PostsModel>>> getPosts(String url) async{
    try{
      final response = await postsDatasource.getPosts(url);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
    
}