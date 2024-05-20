import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/edit_profile/domain/repositories/edit_profile_repository.dart';

class EditCoverPhotoUsecase implements UseCase<String,CoverPhotoParams>{
  
  EditProfileRepository editProfileRepository;
  EditCoverPhotoUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, String>> call(CoverPhotoParams params) async{
    return await editProfileRepository.updateCoverPhoto(params.coverPhoto,params.email);
  }

}

class CoverPhotoParams{

  final File  coverPhoto;
  final String email;
  CoverPhotoParams({required this.coverPhoto,required this.email});
  
}