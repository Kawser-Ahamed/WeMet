import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_data_entities.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_post_entities.dart';

abstract interface class UserProfileRepository{

  Future<Either<Failure,List<UserProfileDataEntities>>> getUserProfileData(String email);
  Future<Either<Failure,List<UserProfilePostEntities>>> getUserProfilePosts(String email);

}