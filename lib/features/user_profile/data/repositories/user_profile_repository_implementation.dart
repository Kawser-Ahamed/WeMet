import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/user_profile/data/datasource/user_profile_datasource.dart';
import 'package:wemet/features/user_profile/data/model/user_profile_data_model.dart';
import 'package:wemet/features/user_profile/data/model/user_profile_post_model.dart';
import 'package:wemet/features/user_profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImplementation implements UserProfileRepository{
  
  UserProfileDatasource userProfileDatasource;
  UserProfileRepositoryImplementation(this.userProfileDatasource);

  @override
  Future<Either<Failure, List<UserProfileDataModel>>> getUserProfileData(String email) async{
    try{
      final response = await userProfileDatasource.getUserProfileData(email);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserProfilePostModel>>> getUserProfilePosts(String email) async{
    try{
      final response = await userProfileDatasource.getUserProfilePost(email);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

}