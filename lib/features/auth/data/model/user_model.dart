import 'package:wemet/features/auth/domain/entities/user_entities.dart';

class UserModel extends UserEntities{
  UserModel({
    required super.id,
    required super.email, 
    required super.password, 
    required super.firstName, 
    required super.lastName, 
    required super.fullName,
    required super.bio, 
    required super.profileImageUrl, 
    required super.coverPhotoUrl,
    required super.followers, 
    required super.following
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      id: json['id'],
      email: json['email'], 
      password: json['password'],
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

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'id' : id,
      'email': email,
      'firstName' : firstName,
      'lastName' : lastName,
      'fullName' : fullName,
      'bio' : bio,
      'profileImageUrl' : profileImageUrl,
      'coverPhotoUrl' : coverPhotoUrl,
      'followers' : followers,
      'following' : following,
    };
  }

  UserModel copyWith({
    int ? id,
    String ? email,
    String ? password,
    String ? firstName,
    String ? lastName,
    String ? fullName,
    String ? bio,
    String ? profileImageUrl,
    String ? coverPhotoUrl,
    int ? followers,
    int ? following,
  }){
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email, 
      password: password ?? this.password, 
      firstName: firstName ?? this.firstName, 
      lastName: lastName ?? this.lastName, 
      fullName: fullName ?? this.fullName, 
      bio: bio ?? this.bio, 
      profileImageUrl: profileImageUrl ?? this.profileImageUrl, 
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl, 
      followers: followers ?? this.followers, 
      following: following ?? this.following,
    );
  }
}