import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/following/domain/entities/following_data_entities.dart';
import 'package:wemet/features/following/domain/repositories/following_repository.dart';

class FetchFollowingUsecase implements UseCase<Map<int,FollowingDataEntities>,UsersFollowingParams>{
  
  FollowingRepository followingRepository;
  FetchFollowingUsecase(this.followingRepository);

  @override
  Future<Either<Failure, Map<int,FollowingDataEntities>>> call(UsersFollowingParams params) async{
    return await followingRepository.fetchFollowingData(params.email);
  }

}

class UsersFollowingParams{

  final String email;
  UsersFollowingParams({required this.email});

}