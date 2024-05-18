import 'dart:async';

import 'package:equatable/equatable.dart';

class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileDataEvent extends UserProfileEvent{

  final String email;
  final Completer<void> completer;
  UserProfileDataEvent(this.email) : completer = Completer<void>();

}

class UserprofilePostEvent extends UserProfileEvent{
  
  final String email;
  const UserprofilePostEvent(this.email);

}


