import 'package:wemet/features/following/domain/entities/following_data_entities.dart';

class FollowingDataModel extends FollowingDataEntities{
  
  FollowingDataModel({
    required super.id, 
    required super.email, 
    required super.firstName, 
    required super.lastName, 
    required super.fullName, 
    required super.bio, 
    required super.profileImageUrl, 
    required super.coverPhotoUrl, 
    required super.followers, 
    required super.following
  });

  factory FollowingDataModel.fromJson(Map<String,dynamic> json){
    return FollowingDataModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
      coverPhotoUrl: json['coverPhotoUrl'],
      followers: json['followers'],
      following: json['following'],
    );
  }

}