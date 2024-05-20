import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/edit_profile/domain/repositories/edit_profile_repository.dart';

class EditprofilePictureUsecase implements UseCase<String,ProfilePictureParams>{
  
  EditProfileRepository editProfileRepository;
  EditprofilePictureUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, String>> call(ProfilePictureParams params) async{
    return await editProfileRepository.updateProfilePicture(params.profilePicture,params.email);
  }

}

class ProfilePictureParams{

  final File  profilePicture;
  final String email;
  ProfilePictureParams({required this.email,required this.profilePicture});
  
}
