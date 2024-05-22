
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
  final String fullName;
  final BuildContext context;

  const AddFollowingEvent({
    required this.userEmail,
    required this.followingEmail,
    required this.fullName,
    required this.context,
  });
  
  @override
  List<Object> get props => [userEmail,followingEmail,fullName,context];
}

class FetchFollowingEvent extends FollowingEvent{

  final String email;
  const FetchFollowingEvent({required this.email});
  
}

class RemoveFollowingEvent extends FollowingEvent{
  
  final String userEmail;
  final String followingEmail;
  final String fullName;
  final BuildContext context;

  const RemoveFollowingEvent({
    required this.userEmail,
    required this.followingEmail,
    required this.fullName,
    required this.context,
  });
  
  @override
  List<Object> get props => [userEmail,followingEmail,fullName,context];
}
