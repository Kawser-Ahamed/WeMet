import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/profile/domain/entities/profile_entities.dart';
import 'package:wemet/features/profile/domain/repositories/profile_repository.dart';

class ProfileUsecase implements UseCase<List<ProfileEntities>,ProfileParam>{

  ProfileRepository profileRepository;
  ProfileUsecase(this.profileRepository);

  @override
  Future<Either<Failure, List<ProfileEntities>>> call(ProfileParam params) async{
    return await profileRepository.getProfileData(params.email);
  }
}

class ProfileParam{
  final String email;
  ProfileParam({required this.email});
}