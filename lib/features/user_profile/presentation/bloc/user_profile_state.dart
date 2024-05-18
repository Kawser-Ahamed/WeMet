
import 'package:equatable/equatable.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_data_entities.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_post_entities.dart';

class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

class UserProfileDataState extends UserProfileState{

  final List<UserProfileDataEntities> userprofileData;
  const UserProfileDataState(this.userprofileData);
  
  @override
  List<Object> get props => [userprofileData];
}

class UserProfilePostState extends UserProfileState{

  final List<UserProfilePostEntities> userProfilePost;
  const UserProfilePostState(this.userProfilePost);

  @override
  List<Object> get props => [userProfilePost];
}

