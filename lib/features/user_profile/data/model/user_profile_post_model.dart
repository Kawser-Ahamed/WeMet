import 'package:wemet/features/user_profile/domain/entities/user_profile_post_entities.dart';

class UserProfilePostModel extends UserProfilePostEntities{
  
  UserProfilePostModel({
    required super.id, 
    required super.caption, 
    required super.imageUrl, 
    required super.dateTime, 
    required super.uploaderName, 
    required super.email, 
    required super.uploaderProfilePictureImageUrl
  });

}