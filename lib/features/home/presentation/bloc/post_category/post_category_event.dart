import 'package:equatable/equatable.dart';

class PostCategoryEvent extends Equatable {
  const PostCategoryEvent();

  @override
  List<Object> get props => [];
}

class SelectedCategoryevent extends PostCategoryEvent{

  final int index;
  const SelectedCategoryevent({required this.index});
}
