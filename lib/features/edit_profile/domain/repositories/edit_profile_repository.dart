import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/edit_profile/domain/entities/edit_profile_entities.dart';

abstract interface class EditProfileRepository{
  Future<Either<Failure,String>> updateProfile(EditProfileEntities editProfileEntities);
  Future<Either<Failure,String>> updateProfilePicture(File profilePicture,String email);
  Future<Either<Failure,String>> updateCoverPhoto(File coverPhoto,String email);
}