
import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object> get props => [];
}

class UploadPostWithImageByUserEvent extends UploadPostEvent{

  final int id;
  final String caption;
  final File imageUrl;
  final String dateTime;
  final String uploaderName;
  final String email;
  final String uploaderProfilePictureImageUrl;

  const UploadPostWithImageByUserEvent({
    required this.id,
    required this.caption,
    required this.imageUrl,
    required this.dateTime,
    required this.uploaderName,
    required this.email,
    required this.uploaderProfilePictureImageUrl,
  });
  
}

class UploadPostWithoutImageByUserEvent extends UploadPostEvent{

  final int id;
  final String caption;
  final String dateTime;
  final String uploaderName;
  final String email;
  final String uploaderProfilePictureImageUrl;

  const UploadPostWithoutImageByUserEvent({
    required this.id,
    required this.caption,
    required this.dateTime,
    required this.uploaderName,
    required this.email,
    required this.uploaderProfilePictureImageUrl,
  });
  
}

