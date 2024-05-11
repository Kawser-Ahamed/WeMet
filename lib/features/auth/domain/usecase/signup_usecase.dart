
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';
import 'package:wemet/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<UserEntities,SignUpParams>{
  
  AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntities>> call(SignUpParams params) async{
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email, 
      password: params.password,
       firstName: params.firstName, 
       lastName: params.lastName, 
       fullName: params.fullName, 
       bio: params.bio, 
       profileImageUrl: params.profileImageUrl, 
       coverPhotoUrl: params.coverPhotoUrl, 
       followers: params.followers, 
       following: params.following
    );
  }

}

class SignUpParams{
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String fullName;
  final String bio;
  final File profileImageUrl;
  final File coverPhotoUrl;
  final int followers;
  final int following;

    SignUpParams({
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.bio,
      required this.profileImageUrl,
      required this.coverPhotoUrl,
      required this.followers,
      required this.following,
    });
}