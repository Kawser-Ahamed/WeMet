import 'package:equatable/equatable.dart';

class AuthState extends Equatable{
  
  final String message;
  
  const AuthState({
    this.message = '',
  });

  AuthState copyWith({String ? message}){
    return AuthState(message: message ?? this.message);
  }
  
  @override
  List<Object?> get props => [message];
}


