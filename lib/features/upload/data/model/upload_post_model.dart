import 'package:wemet/features/upload/domain/entities/upload_post_entities.dart';

class UploadPostModel extends UploadPostEntities{

  UploadPostModel({
    required super.id, 
    required super.caption, 
    required super.imageUrl, 
    required super.dateTime, 
    required super.uploaderName, 
    required super.email,
    required super.uploaderProfilePictureImageUrl,
    required super.postCategory,
  });

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'id' : id,
      'caption' : caption,
      'imageUrl' : imageUrl,
      'dateTime' : dateTime,
      'uploaderName' : uploaderName,
      'email' : email,
      'uploaderProfilePictureImageUrl' : uploaderProfilePictureImageUrl,
      'postCategory' : postCategory,
    };
  }

  UploadPostModel copyWith({
    int ? id,
    String ? caption,
    String ? imageUrl,
    String ? dateTime,
    String ? uploaderName,
    String ? email,
    String ? uploaderProfilePictureImageUrl,
    String ? postCategory,
  }){
    return UploadPostModel(
      id: id ?? this.id, 
      caption: caption ?? this.caption, 
      imageUrl: imageUrl ?? this.imageUrl, 
      dateTime: dateTime ?? this.dateTime, 
      uploaderName: uploaderName ?? this.uploaderName, 
      email: email ?? this.email,
      uploaderProfilePictureImageUrl: uploaderProfilePictureImageUrl ?? this.uploaderProfilePictureImageUrl,
      postCategory: postCategory ?? this.postCategory,
    );
  }

}