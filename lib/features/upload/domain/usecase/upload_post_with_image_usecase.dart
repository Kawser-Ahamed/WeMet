import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/upload/domain/repositories/upload_post_repository.dart';

class UploadPostWithImageUsecase implements UseCase<String,UploadPostWithImageParams>{
  
  UploadPostRepository uploadPostRepository;
  UploadPostWithImageUsecase(this.uploadPostRepository);

  @override
  Future<Either<Failure, String>> call(UploadPostWithImageParams params) async{
    return await uploadPostRepository.uploadPostWithImage(
      id: params.id,
      caption: params.caption,
      dateTime: params.dateTime,
      imageUrl: params.imageUrl!,
      uploaderName: params.uploaderName,
      email: params.emai,
      uploaderProfilePictureImageUrl: params.uploaderProfilePictureImageUrl,
    );
  }
}

class UploadPostWithImageParams{

  final int id;
  final String caption;
  final File ? imageUrl;
  final String dateTime;
  final String uploaderName;
  final String emai;
  final String uploaderProfilePictureImageUrl;
  
  UploadPostWithImageParams({
    required this.id,
    required this.caption,
    required this.imageUrl,
    required this.dateTime,
    required this.uploaderName,
    required this.emai,
    required this.uploaderProfilePictureImageUrl,
  });
}