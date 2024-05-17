import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/upload/data/datasource/upload_post_datasource.dart';
import 'package:wemet/features/upload/data/model/upload_post_model.dart';
import 'package:wemet/features/upload/domain/repositories/upload_post_repository.dart';

class UploadPostRepositoriesImplementation implements UploadPostRepository{
  
  UploadPostDatasource uploadPostDatasource;
  UploadPostRepositoriesImplementation(this.uploadPostDatasource);

  @override
  Future<Either<Failure, String>> uploadPostWithImage({
    required int id, 
    required String caption, 
    required File ? imageUrl,
    required String dateTime, 
    required String uploaderName,
    required String email,
    required String uploaderProfilePictureImageUrl,
    required String category,
  }) async{
    try{
      String imageUrlFromFirebase = '';
      UploadPostModel uploadPostModel = UploadPostModel(
        id: id, 
        caption: caption, 
        imageUrl: '', 
        dateTime: dateTime, 
        uploaderName: uploaderName, 
        email: email,
        uploaderProfilePictureImageUrl: uploaderProfilePictureImageUrl
      );

      imageUrlFromFirebase = await uploadPostDatasource.uploadAttachmentImage(imageUrl: imageUrl!);
        uploadPostModel = uploadPostModel.copyWith(
          imageUrl: imageUrlFromFirebase,
        );

      final response = await uploadPostDatasource.uploadPost(uploadPostModel,category);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> uploadPostWithoutImage({
    required int id, 
    required String caption, 
    required String dateTime, 
    required String uploaderName, 
    required String email, 
    required String uploaderProfilePictureImageUrl,
    required String category,
   }) async{
    try{
      UploadPostModel uploadPostModel = UploadPostModel(
        id: id, 
        caption: caption, 
        imageUrl: '', 
        dateTime: dateTime, 
        uploaderName: uploaderName, 
        email: email,
        uploaderProfilePictureImageUrl: uploaderProfilePictureImageUrl
      );
      
      final response = await uploadPostDatasource.uploadPost(uploadPostModel,category);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
}