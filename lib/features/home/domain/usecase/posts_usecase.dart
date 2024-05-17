import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/home/domain/entities/posts_entities.dart';
import 'package:wemet/features/home/domain/repositories/posts_repository.dart';

class PostsUsecase implements UseCase<List<PostsEntities>,NoParams>{

  PostsRepository postsRepository;
  PostsUsecase(this.postsRepository);

  @override
  Future<Either<Failure, List<PostsEntities>>> call(NoParams params) async{
    return await postsRepository.getPosts();
  }

}