import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';

abstract interface class AuthRepository{

  Future<Either<Failure,UserEntities>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String fullName,
    required String bio,
    required File profileImageUrl,
    required File coverPhotoUrl,
    required int followers,
    required int following,
  });

  Future<Either<Failure,List<UserEntities>>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure,List<UserEntities>>> getUserData(String email);
}