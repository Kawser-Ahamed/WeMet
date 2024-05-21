
import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_data_entities.dart';
import 'package:wemet/features/user_profile/domain/entities/user_profile_post_entities.dart';

class UserProfileState extends Equatable {

  final List<UserProfilePostEntities> userProfilePost;
  final List<UserProfileDataEntities> userprofileData;
  final UiStatus uiStatus;
  final String message;

  const UserProfileState({
    this.userprofileData = const [],
    this.userProfilePost = const [],
    this.uiStatus = UiStatus.loading,
    this.message = '',
  });

  UserProfileState copyWith({
    List<UserProfileDataEntities> ? userprofileData,
    List<UserProfilePostEntities> ? userProfilePost,
    UiStatus ? uiStatus,
    String ? message,
  }){
    return UserProfileState(
      userprofileData: userprofileData ?? this.userprofileData,
      userProfilePost: userProfilePost ?? this.userProfilePost,
      uiStatus: uiStatus ?? this.uiStatus,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [userProfilePost,userprofileData,uiStatus,message];
}
