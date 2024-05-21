import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/search/domain/entities/search_user_entities.dart';
import 'package:wemet/features/search/domain/repositories/search_repository.dart';

class SearchUserUsecase implements UseCase<List<SearchUserEntities>,SeacrhParams>{

  SearchRepository searchRepository;
  SearchUserUsecase(this.searchRepository);

  @override
  Future<Either<Failure, List<SearchUserEntities>>> call(SeacrhParams params) async{
    return await searchRepository.getSearchUser(params.searchValue);
  }

}

class SeacrhParams{

  final String searchValue;
  SeacrhParams({required this.searchValue});

}