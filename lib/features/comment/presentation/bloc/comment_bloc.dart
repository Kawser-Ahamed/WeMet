import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/comment/domain/entities/comment_entities.dart';
import 'package:wemet/features/comment/domain/usecase/fetch_comment_usecase.dart';
import 'package:wemet/features/comment/domain/usecase/upload_comment_usecase.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_event.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_state.dart';

class CommentBloc extends Bloc<Commentevent, CommentState> {
  
  final FetchCommentUsecase _fetchCommentUsecase;
  final UploadCommentUsecase _uploadCommentUsecase;

  CommentBloc({
    required FetchCommentUsecase fetchCommentUsecase,
    required UploadCommentUsecase uploadCommentUsecase
  }) :_fetchCommentUsecase = fetchCommentUsecase,
      _uploadCommentUsecase = uploadCommentUsecase, 
    super(const CommentState()) {
    on<UploadCommentEvent>(_uploadComment);
    on<FetchCommentEvent>(_fetchComment);
  }

  Future<void> _uploadComment(UploadCommentEvent event, Emitter<CommentState> emit)async {
    final response = await _uploadCommentUsecase(
      CommentEntities(
        id: event.id.toString(), 
        comment: event.comment, 
        dateTime: event.dateTime, 
        commenterName: event.commenterName, 
        email: event.email, 
        commenterProfilePictureImageUrl: event.commenterProfilePictureImageUrl,
      )
    );

    response.fold(
      (l) => emit(state.copyWith(message: l.message)), 
      (r)=>emit(state.copyWith(message: r)),
    );
  }

  Future<void> _fetchComment(FetchCommentEvent event, Emitter<CommentState> emit) async{
    final response = await _fetchCommentUsecase(FetchCommentParams(id: event.id));
    response.fold(
      (l) => emit(state.copyWith(message: l.message,uiStatus: UiStatus.error,commentData: [])), 
      (r){
        emit(state.copyWith(commentData: r,uiStatus: UiStatus.success,message: 'Success'));
      },
    );
  }
}
