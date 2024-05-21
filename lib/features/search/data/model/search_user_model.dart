import 'package:wemet/features/search/domain/entities/search_user_entities.dart';

class SearchUserModel extends SearchUserEntities{
  
  SearchUserModel({
    required super.id, 
    required super.email, 
    required super.firstName, 
    required super.lastName, 
    required super.fullName, 
    required super.bio, 
    required super.profileImageUrl, 
    required super.coverPhotoUrl, 
    required super.followers, 
    required super.following,
  });

  factory SearchUserModel.fromJson(Map<String,dynamic> json){
    return SearchUserModel(
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