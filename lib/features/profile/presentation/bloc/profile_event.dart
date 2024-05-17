import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileDataEvent extends ProfileEvent{

  final String email;
  const ProfileDataEvent({required this.email});
  
}
