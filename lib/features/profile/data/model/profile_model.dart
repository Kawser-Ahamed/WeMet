import 'package:wemet/features/profile/domain/entities/profile_entities.dart';

class ProfileModel extends ProfileEntities{
  
  ProfileModel({
    required super.id, 
    required super.caption, 
    required super.imageUrl, 
    required super.dateTime, 
    required super.uploaderName, 
    required super.email, 
    required super.uploaderProfilePictureImageUrl
  });

  factory ProfileModel.fromJson(Map<String,dynamic> json){
    return ProfileModel(
      id: json['id'], 
      caption: json['caption'], 
      imageUrl: json['imageUrl'], 
      dateTime: json['dateTime'], 
      uploaderName: json['uploaderName'], 
      email: json['email'], 
      uploaderProfilePictureImageUrl: json['uploaderProfilePictureImageUrl']
    );
  }
}