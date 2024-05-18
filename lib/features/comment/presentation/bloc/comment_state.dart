import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/comment/domain/entities/comment_entities.dart';

class CommentState extends Equatable {

  final String message;
  final List<CommentEntities> commentData;
  final UiStatus uiStatus;

  const CommentState({
    this.message = '',
    this.uiStatus = UiStatus.loading,
    this.commentData = const [],
  });

  CommentState copyWith({String ? message,List<CommentEntities> ? commentData,UiStatus ? uiStatus}){
    return CommentState(
      message: message ?? this.message,
      commentData: commentData ?? this.commentData,
      uiStatus: uiStatus ?? this.uiStatus,
    );
  }
  
  @override
  List<Object> get props => [message,commentData,uiStatus];
}
