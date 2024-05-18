import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_post_entities.dart';
import 'package:wemet/features/user_profile/domain/repositories/user_profile_repository.dart';

class UserProfilePostUsecase implements UseCase<List<UserProfilePostEntities>,Userparams>{
  
  UserProfileRepository userProfileRepository;
  UserProfilePostUsecase(this.userProfileRepository);

  @override
  Future<Either<Failure,List<UserProfilePostEntities>>> call(Userparams params) async {
    return await userProfileRepository.getUserProfilePosts(params.email);
  }
}

class Userparams{

  final String email;
  Userparams({required this.email});

}