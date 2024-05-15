import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/upload/domain/usecase/uplaod_post_without_image_usecase.dart';
import 'package:wemet/features/upload/domain/usecase/upload_post_with_image_usecase.dart';
import 'package:wemet/features/upload/presentation/bloc/upload_post_event.dart';
import 'package:wemet/features/upload/presentation/bloc/upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {

  final UploadPostWithImageUsecase _uploadPostWithImageUsecase;
  final UploadPostWithoutImageUsecase _uploadPostWithoutImageUsecase;
  UploadPostBloc({
    required UploadPostWithImageUsecase uploadPostWithImageUsecase,
    required UploadPostWithoutImageUsecase uploadPostWithoutImageUsecase,
  }) : _uploadPostWithImageUsecase = uploadPostWithImageUsecase,
      _uploadPostWithoutImageUsecase = uploadPostWithoutImageUsecase, 
      super(const UploadPostState()) {
    on<UploadPostWithImageByUserEvent>(_uploadPostWithImage);
    on<UploadPostWithoutImageByUserEvent>(_uploadPostWithoutImage);
  }

  Future<void> _uploadPostWithImage(UploadPostWithImageByUserEvent event, Emitter<UploadPostState> emit) async{
    final response = await _uploadPostWithImageUsecase(
      UploadPostWithImageParams(
        id: event.id, 
        caption: event.caption, 
        imageUrl: event.imageUrl, 
        dateTime: event.dateTime, 
        uploaderName: event.uploaderName, 
        emai: event.email, 
        uploaderProfilePictureImageUrl: event.uploaderProfilePictureImageUrl
      ),
    );
    response.fold(
      (l) => emit(state.copyWith(message: l.message.toString(),uiStatus: UiStatus.error)), 
      (r) => emit(state.copyWith(message: r,uiStatus: UiStatus.success)),
    );
  }

  Future<void> _uploadPostWithoutImage(UploadPostWithoutImageByUserEvent event, Emitter<UploadPostState> emit) async{
    final response = await _uploadPostWithoutImageUsecase(
      UploadPostWithoutImageParams(
        id: event.id, 
        caption: event.caption, 
        dateTime: event.dateTime, 
        uploaderName: event.uploaderName, 
        emai: event.email, 
        uploaderProfilePictureImageUrl: event.uploaderProfilePictureImageUrl
      ),
    );
    response.fold(
      (l) => emit(state.copyWith(message: l.message.toString(),uiStatus: UiStatus.error)), 
      (r) => emit(state.copyWith(message: r,uiStatus: UiStatus.success)),
    );
  }
}
