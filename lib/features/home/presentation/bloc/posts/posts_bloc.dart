import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/home/domain/usecase/posts_usecase.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_event.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_state.dart';

class PostsBloc extends Bloc<AllPostsEvent,AllPostsState>{
  
  final PostsUsecase _postsUsecase;
  PostsBloc({
    required PostsUsecase postsUsecase,
  }) : _postsUsecase = postsUsecase, super(const AllPostsState()){
    on<AllPostsEvent>(_getAllPosts);
  }

  Future<void> _getAllPosts(AllPostsEvent event, Emitter<AllPostsState> emit) async{
    final response = await _postsUsecase(UrlParam(url: event.url));
    response.fold(
      (l) => emit(state.copyWith(message: l.message,uiStatus: UiStatus.error)), 
      (r) => emit(state.copyWith(postData: r,uiStatus: UiStatus.success)),
    );
  }

}