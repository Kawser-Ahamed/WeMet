import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileDataEvent extends EditProfileEvent{

  final String fullName;
  final String bio;
  final String email;
  final BuildContext context;
  
  const EditProfileDataEvent({
    required this.fullName,
    required this.bio,
    required this.email,
    required this.context
  });
  
}

class EditProfilePictureEvent extends EditProfileEvent{
  
  final String email;
  final File profilePicture;
  final BuildContext context;
  const EditProfilePictureEvent({required this.context, required this.email, required this.profilePicture});

}

class EditCoverPhotoEvent extends EditProfileEvent{
  
  final String email;
  final File coverPhoto;
  final BuildContext context;
  const EditCoverPhotoEvent({required this.email, required this.context, required this.coverPhoto});

}
