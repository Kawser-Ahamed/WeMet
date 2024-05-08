
import 'dart:io';

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
  });
}
