import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/home/domain/entities/post_category_entities.dart';
import 'package:wemet/features/home/domain/repositories/post_category_repository.dart';

class PostCategoryUseCase implements UseCase<List<PostCategoryEntities>,NoParams>{
  
  PostCategoryrepository postCategoryrepository;
  PostCategoryUseCase(this.postCategoryrepository);

  @override
  Future<Either<Failure, List<PostCategoryEntities>>> call(NoParams params) async{
     return await postCategoryrepository.getPostCategory();
  }
}