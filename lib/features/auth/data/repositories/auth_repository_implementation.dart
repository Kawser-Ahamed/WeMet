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
      final res = await authDatasource.signUpWithEmailAndPassword(userModel);
      return right(res);
    }
    catch (error){
      return left(Failure(error.toString()));
    }
  }

}