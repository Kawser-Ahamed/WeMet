import 'package:wemet/features/user_profile/domain/entities/user_profile_data_entities.dart';

class UserProfileDataModel extends UserProfileDataEntities{
  
  UserProfileDataModel({
    required super.id, 
    required super.email, 
    required super.fullName, 
    required super.bio, 
    required super.profileImageUrl, 
    required super.coverPhotoUrl, 
    required super.followers, 
    required super.following
  });
  
}