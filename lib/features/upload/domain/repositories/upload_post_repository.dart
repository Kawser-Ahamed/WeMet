import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';

abstract interface class UploadPostRepository{
  
  Future<Either<Failure,String>> uploadPostWithImage({
    required int id,
    required String caption,
    required File ? imageUrl,
    required String dateTime,
    required String uploaderName,
    required String email,
    required String uploaderProfilePictureImageUrl,
  });

  Future<Either<Failure,String>> uploadPostWithoutImage({
    required int id,
    required String caption,
    required String dateTime,
    required String uploaderName,
    required String email,
    required String uploaderProfilePictureImageUrl,
  });
}