import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/search/domain/entities/search_user_entities.dart';

abstract interface class SearchRepository{
  Future<Either<Failure,List<SearchUserEntities>>> getRandomUser();
  Future<Either<Failure,List<SearchUserEntities>>> getSearchUser(String searchValue);
}