
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FollowingEvent extends Equatable {

  const FollowingEvent();

  @override
  List<Object> get props => [];
}

class AddFollowingEvent extends FollowingEvent{
  
  final String userEmail;
  final String followingEmail;
  final BuildContext context;

  const AddFollowingEvent({
    required this.userEmail,
    required this.followingEmail,
    required this.context,
  });
  
  @override
  List<Object> get props => [userEmail,followingEmail,context];
}
