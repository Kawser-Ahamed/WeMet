import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Commentevent extends Equatable{
  @override
  List<Object?> get props => [];

}

class UploadCommentEvent extends Commentevent {

  final int id;
  final String comment;
  final String dateTime;
  final String commenterName;
  final String email;
  final String commenterProfilePictureImageUrl;
  final BuildContext context;

  UploadCommentEvent({
    required this.id, 
    required this.comment, 
    required this.dateTime, 
    required this.commenterName, 
    required this.email, 
    required this.commenterProfilePictureImageUrl, 
    required this.context, 
  });

}

class FetchCommentEvent extends Commentevent{

  final int id;
  FetchCommentEvent({required this.id});
  
}
