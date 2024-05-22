import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/following/domain/entities/following_data_entities.dart';

class FollowingState extends Equatable {

  final String message;
  final UiStatus uiStatus;
  final List<FollowingDataEntities> followingData;
  final Map<int,FollowingDataEntities> followingUserMap;
  
  const FollowingState({
    this.message = '',
    this.uiStatus = UiStatus.loading,
    this.followingData = const [],
    this.followingUserMap = const {},
  });

  FollowingState copyWith({
    String ? message,
    UiStatus ? uiStatus,
    List<FollowingDataEntities> ? followingData,
    Map<int,FollowingDataEntities> ? followingUserMap,
  }){
    return FollowingState(
      message: message ?? this.message,
      followingData: followingData ?? this.followingData,
      uiStatus: uiStatus ?? this.uiStatus,
      followingUserMap: followingUserMap ?? this.followingUserMap,
    );
  }
  
  @override
  List<Object> get props => [message,uiStatus,followingData,followingUserMap];
}

