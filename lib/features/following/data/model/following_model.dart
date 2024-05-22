import 'package:wemet/features/following/domain/entities/following_entities.dart';

class FollowingModel extends FollowingEntities{
  
  FollowingModel({
    required super.userEmail, 
    required super.followingEmail
  });

  Map<String,dynamic> toJosn(){
    return <String,dynamic>{
      'userEmail' : userEmail,
      'followingEmail' : followingEmail,
    };
  }

}