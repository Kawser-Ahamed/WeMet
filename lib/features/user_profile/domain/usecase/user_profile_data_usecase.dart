import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_data_entities.dart';
import 'package:wemet/features/user_profile/domain/repositories/user_profile_repository.dart';

class UserProfileDataUsecase implements UseCase<List<UserProfileDataEntities>,Userparams>{
  
  UserProfileRepository userProfileRepository;
  UserProfileDataUsecase(this.userProfileRepository);

  @override
  Future<Either<Failure, List<UserProfileDataEntities>>> call(Userparams params) async {
    return await userProfileRepository.getUserProfileData(params.email);
  }
}

class Userparams{

  final String email;
  Userparams({required this.email});

}