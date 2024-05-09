import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';

class AuthState extends Equatable{
  
  final List<UserEntities> userData;
  final String message;
  final UiStatus uiStatus;
  
  const AuthState({
    this.userData = const [],
    this.message = '',
    this.uiStatus = UiStatus.loading,
  });

  AuthState copyWith({List<UserEntities> ? userData,String ? message,UiStatus ? uiStatus}){
    return AuthState(
      userData: userData ?? this.userData,
      message: message ?? this.message,
      uiStatus:  uiStatus ?? this.uiStatus,
    );
  }
  
  @override
  List<Object?> get props => [userData,message,uiStatus];
}


