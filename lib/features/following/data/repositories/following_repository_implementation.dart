import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/following/data/datasource/following_datasource.dart';
import 'package:wemet/features/following/data/model/following_data_model.dart';
import 'package:wemet/features/following/data/model/following_model.dart';
import 'package:wemet/features/following/domain/entities/following_entities.dart';
import 'package:wemet/features/following/domain/repositories/following_repository.dart';

class FollowingRepositoryImplementation implements FollowingRepository{
  
  FollowingDatasource followingDatasource;
  FollowingRepositoryImplementation(this.followingDatasource);

  @override
  Future<Either<Failure, String>> addFollowing(FollowingEntities followingEntities) async{
    try{
      FollowingModel followingModel = FollowingModel(
        userEmail: followingEntities.userEmail, 
        followingEmail: followingEntities.followingEmail,
      );
      final response = await followingDatasource.addFollowing(followingModel);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Map<int,FollowingDataModel>>> fetchFollowingData(String email) async{
    try{
      final response = await followingDatasource.fetchFollowingData(email);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> removeFollowing(FollowingEntities followingEntities) async{
    try{
      FollowingModel followingModel = FollowingModel(
        userEmail: followingEntities.userEmail, 
        followingEmail: followingEntities.followingEmail,
      );
      final response = await followingDatasource.removeFollowing(followingModel);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

}