import 'package:equatable/equatable.dart';

class PostsEvent extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AllPostsEvent extends PostsEvent{

  final String url;
  AllPostsEvent({required this.url});
}