import 'package:equatable/equatable.dart';

class FollowingState extends Equatable {

  final String message;
  
  const FollowingState({
    this.message = '',
  });

  FollowingState copyWith({
    String ? message,
  }){
    return FollowingState(
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [message];
}

