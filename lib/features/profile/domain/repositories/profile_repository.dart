import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/profile/domain/entities/profile_entities.dart';

abstract interface class ProfileRepository{
  Future<Either<Failure,List<ProfileEntities>>> getProfileData(String email);
}