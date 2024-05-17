import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/home/domain/entities/posts_entities.dart';

class AllPostsState extends Equatable{
  
  final List<PostsEntities> postData;
  final UiStatus uiStatus;
  final String message;

  const AllPostsState({
    this.postData = const [],
    this.uiStatus = UiStatus.loading,
    this.message = '',
  });

  AllPostsState copyWith({List<PostsEntities> ? postData, UiStatus ? uiStatus, String ? message}){
    return AllPostsState(
      postData: postData ?? this.postData,
      message: message ?? this.message,
      uiStatus: uiStatus ?? this.uiStatus,
    );
  }

  @override
  List<Object?> get props => [postData,uiStatus,message];
}