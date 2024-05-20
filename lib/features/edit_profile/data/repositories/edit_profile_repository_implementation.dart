import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/edit_profile/data/datasource/edit_profile_datasource.dart';
import 'package:wemet/features/edit_profile/data/model/edit_profile_mdoel.dart';
import 'package:wemet/features/edit_profile/domain/entities/edit_profile_entities.dart';
import 'package:wemet/features/edit_profile/domain/repositories/edit_profile_repository.dart';

class EditProfileRepositoryImplementation implements EditProfileRepository{
  
  EditProfileDataSource editProfileDataSource;
  EditProfileRepositoryImplementation(this.editProfileDataSource);

  @override
  Future<Either<Failure, String>> updateProfile(EditProfileEntities editProfileEntities) async{
    try{
      EditprofileModel editprofileModel = EditprofileModel(
        fullName: editProfileEntities.fullName, 
        bio: editProfileEntities.bio,
        email: editProfileEntities.email,
      );
      final response = await editProfileDataSource.updateProfile(editprofileModel);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfilePicture(File profilePicture,String email) async{
    try{
      final response = await editProfileDataSource.updateprofilePicture(profilePicture,email);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateCoverPhoto(File coverPhoto,String email) async{
    try{
      final response = await editProfileDataSource.updateCoverphoto(coverPhoto,email);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
  
}