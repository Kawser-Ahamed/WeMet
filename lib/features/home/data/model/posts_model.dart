import 'package:wemet/features/home/domain/entities/posts_entities.dart';

class PostsModel extends PostsEntities{
  
  PostsModel({
    required super.id, 
    required super.caption, 
    required super.imageUrl, 
    required super.dateTime, 
    required super.uploaderName, 
    required super.email, 
    required super.uploaderProfilePictureImageUrl
  });

  factory PostsModel.fromJson(Map<String,dynamic> json){
    return PostsModel(
      id: json['id'], 
      caption: json['caption'], 
      imageUrl: json['imageUrl'], 
      dateTime: json['dateTime'], 
      uploaderName: json['uploaderName'], 
      email: json['email'], 
      uploaderProfilePictureImageUrl: json['uploaderProfilePictureImageUrl'],
    );
  }

}