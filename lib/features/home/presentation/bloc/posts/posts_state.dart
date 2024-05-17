import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/home/domain/entities/posts_entities.dart';

class AllPostsState extends Equatable{
  
  final List<PostsEntities> allPostData;
  final UiStatus uiStatus;
  final String message;

  const AllPostsState({
    this.allPostData = const [],
    this.uiStatus = UiStatus.loading,
    this.message = '',
  });

  AllPostsState copyWith({List<PostsEntities> ? allPostData, UiStatus ? uiStatus, String ? message}){
    return AllPostsState(
      allPostData: allPostData ?? this.allPostData,
      message: message ?? this.message,
      uiStatus: uiStatus ?? this.uiStatus,
    );
  }

  @override
  List<Object?> get props => [allPostData,uiStatus,message];
}