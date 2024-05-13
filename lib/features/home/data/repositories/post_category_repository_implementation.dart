import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/home/data/datasource/post_category_datasource.dart';
import 'package:wemet/features/home/data/model/post_category_model.dart';
import 'package:wemet/features/home/domain/repositories/post_category_repository.dart';

class PostCategoryRepositoryImplementation implements PostCategoryrepository{
  
  PostCategoryDatasource postCategoryDatasource;
  PostCategoryRepositoryImplementation(this.postCategoryDatasource);

  @override
  Future<Either<Failure, List<PostCategoryModel>>> getPostCategory() async{
    try{
      final response = await postCategoryDatasource.getPostCategory();
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }



}