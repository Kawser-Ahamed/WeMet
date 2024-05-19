import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/auth/data/datasource/auth_datasource.dart';
import 'package:wemet/features/auth/data/model/user_model.dart';
import 'package:wemet/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository{

  AuthDatasource authDatasource;
  AuthRepositoryImplementation(this.authDatasource);

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    required String email, 
    required String password, 
    required String firstName, 
    required String lastName, 
    required String fullName, 
    required String bio, 
    required File profileImageUrl, 
    required File coverPhotoUrl, 
    required int followers, 
    required int following
  }) async{
    try{
      UserModel userModel = UserModel(
        id: DateTime.now().microsecondsSinceEpoch,
        email: email, 
        password: password, 
        firstName: firstName, 
        lastName: lastName, 
        fullName: fullName, 
        bio: bio, 
        profileImageUrl: '', 
        coverPhotoUrl: '', 
        followers: followers,
        following: following,
      );
      String profilePictureImageUrl = await authDatasource.uploadProfilePicture(profileImageUrl);
      String coverPhotoImageUrl = await authDatasource.uploadCoverPhoto(coverPhotoUrl);
      userModel = userModel.copyWith(
        profileImageUrl: profilePictureImageUrl,
        coverPhotoUrl: coverPhotoImageUrl,
      );
      final response = await authDatasource.signUpWithEmailAndPassword(userModel);
      return right(response);
    }
    catch (error){
      return left(Failure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<UserModel>>> signInWithEmailAndPassword({required String email, required String password}) async{
    try{
      final response = await authDatasource.signInWithEmailAndPassword(email, password);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUserData(String email) async{
    try{
      final response = await authDatasource.getUserData(email);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
}