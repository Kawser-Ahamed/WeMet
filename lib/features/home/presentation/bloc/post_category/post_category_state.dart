import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/home/domain/entities/post_category_entities.dart';

class PostCategoryState extends Equatable {

  final List<PostCategoryEntities> postCategoryData;
  final UiStatus uiStatus;
  final String errorMessage;
  final int selectedIndex;

  const PostCategoryState({
    this.postCategoryData = const [],
    this.uiStatus = UiStatus.loading,
    this.errorMessage = '',
    this.selectedIndex = 0,
  });

  PostCategoryState copyWith({
    final List<PostCategoryEntities>? postCategoryData,
    final UiStatus ? uiStatus,
    final String ? errorMessage,
    final int ? selectedIndex,
  }){
    return PostCategoryState(
      postCategoryData: postCategoryData ?? this.postCategoryData,
      uiStatus: uiStatus ?? this.uiStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
  
  @override
  List<Object> get props => [postCategoryData,uiStatus,errorMessage,selectedIndex];
}

