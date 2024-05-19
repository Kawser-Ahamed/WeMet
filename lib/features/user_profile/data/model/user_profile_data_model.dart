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
  
  factory UserProfileDataModel.fromJson(Map<String,dynamic> json){
    return UserProfileDataModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
      coverPhotoUrl: json['coverPhotoUrl'],
      followers: json['followers'],
      following: json['following'],
    );
  }
  
}