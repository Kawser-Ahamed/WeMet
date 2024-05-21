import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/search/domain/entities/search_user_entities.dart';
import 'package:wemet/features/search/domain/repositories/search_repository.dart';

class RandomUserUsecase implements UseCase<List<SearchUserEntities>,NoParams>{

  SearchRepository searchRepository;
  RandomUserUsecase(this.searchRepository);
  
  @override
  Future<Either<Failure, List<SearchUserEntities>>> call(NoParams params) async{
    return await searchRepository.getRandomUser();
  }

}