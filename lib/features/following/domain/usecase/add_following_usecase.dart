import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/following/domain/entities/following_entities.dart';
import 'package:wemet/features/following/domain/repositories/following_repository.dart';

class AddFollowingUsecase implements UseCase<String,FollowingEntities>{
  
  FollowingRepository followingRepository;
  AddFollowingUsecase(this.followingRepository);

  @override
  Future<Either<Failure, String>> call(FollowingEntities params) async{
    return await followingRepository.addFollowing(params);
  }

}
