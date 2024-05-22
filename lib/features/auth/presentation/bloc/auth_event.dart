
import 'dart:io';

import 'package:flutter/widgets.dart';

class AuthEvent {}

class SignUpEvent extends AuthEvent{
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String fullName;
  final String bio;
  final File profileImageUrl;
  final File coverPhotoUrl;
  final int followers;
  final int following;
  final BuildContext context;
  SignUpEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.bio,
    required this.profileImageUrl,
    required this.coverPhotoUrl,
    required this.followers,
    required this.following,
    required this.context,
  });
}

class SignInEvent extends AuthEvent{
  final String email;
  final String password;
  BuildContext context;
     
  SignInEvent({
    required this.email,
    required this.password,
    required this.context,
  });
}

class UserDataEvent extends AuthEvent{
  
  final String email;
  final bool isView;
  BuildContext context;
  UserDataEvent({required this.email,required this.isView,required this.context});
}
