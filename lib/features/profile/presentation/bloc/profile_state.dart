import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/profile/domain/entities/profile_entities.dart';

class ProfileState extends Equatable {
  
  final List<ProfileEntities> profileData;
  final UiStatus uiStatus;
  final String message;

  const ProfileState({
    this.profileData = const [],
    this.uiStatus = UiStatus.loading,
    this.message = '',
  });

  ProfileState copyWith({List<ProfileEntities> ? profileData, UiStatus ? uiStatus, String ? message}){
    return ProfileState(
      profileData: profileData ?? this.profileData,
      message: message ?? this.message,
      uiStatus: uiStatus ?? this.uiStatus,
    );
  }
  
  @override
  List<Object> get props => [profileData,uiStatus,message];
}

