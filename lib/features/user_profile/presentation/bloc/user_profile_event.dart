import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileDataEvent extends UserProfileEvent{

  final String email;
  final BuildContext context;
  const UserProfileDataEvent(this.email,this.context);

}

class UserprofilePostEvent extends UserProfileEvent{
  
  final String email;
  final BuildContext context;
  const UserprofilePostEvent(this.email,this.context);

}


