import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/home/domain/usecase/post_category_usecase.dart';
import 'package:wemet/features/home/presentation/bloc/post_category_event.dart';
import 'package:wemet/features/home/presentation/bloc/post_category_state.dart';

class PostCategoryBloc extends Bloc<PostCategoryEvent, PostCategoryState> {

  final PostCategoryUseCase _postCategoryUseCase;
  PostCategoryBloc({
    required PostCategoryUseCase postCategoryUseCase,
  }) :_postCategoryUseCase= postCategoryUseCase,super(const PostCategoryState()) {
     on<PostCategoryEvent>(_getPostCategory);
  }

   Future _getPostCategory(PostCategoryEvent event, Emitter<PostCategoryState> emit) async{
     final response = await _postCategoryUseCase(NoParams());
     response.fold(
      (l) => emit(state.copyWith(uiStatus: UiStatus.error,errorMessage: l.message)), 
      (r) => emit(state.copyWith(postCategoryData: r,uiStatus: UiStatus.success)),
     );
   }
}
