import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/following/domain/entities/following_entities.dart';

abstract interface class FollowingRepository{

  Future<Either<Failure,String>> addFollowing(FollowingEntities followingEntities);
  
}