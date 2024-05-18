import 'package:wemet/features/comment/domain/entities/comment_entities.dart';

class CommentModel extends CommentEntities{

  CommentModel({
    required super.id, 
    required super.comment, 
    required super.dateTime, 
    required super.commenterName, 
    required super.email, 
    required super.commenterProfilePictureImageUrl
  });

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'id' : id,
      'comment' : comment,
      'dateTime' : dateTime,
      'commenterName' : commenterName,
      'email' : email,
      'commenterProfilePictureImageUrl' : commenterProfilePictureImageUrl,
    };
  }

  factory CommentModel.fromJson(Map<String,dynamic> json){
    return CommentModel(
      id: json['id'],
      comment : json['comment'],
      dateTime: json['dateTime'],
      email: json['email'],
      commenterName: json['commenterName'],
      commenterProfilePictureImageUrl: json['commenterProfilePictureImageUrl'],
    );
  }
}