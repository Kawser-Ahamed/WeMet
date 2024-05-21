import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/search/data/datasource/search_datasource.dart';
import 'package:wemet/features/search/data/model/search_user_model.dart';
import 'package:wemet/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImplementation implements SearchRepository{
  
  SearchDataSource searchDataSource;
  SearchRepositoryImplementation(this.searchDataSource);

  @override
  Future<Either<Failure, List<SearchUserModel>>> getRandomUser() async{
    try{
      final response = await searchDataSource.getRandomUser();
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchUserModel>>> getSearchUser(String searchValue) async{
    try{
      final response = await searchDataSource.getSearchUser(searchValue);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

}