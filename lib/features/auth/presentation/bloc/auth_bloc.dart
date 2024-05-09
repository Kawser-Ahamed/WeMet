// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';
import 'package:wemet/features/auth/domain/usecase/auth_usecase.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc({
    required AuthUseCase authUseCase,
  }) : _authUseCase = authUseCase, super(const AuthState()) {
    on<SignUpEvent>(_signUpWithemailAndPassword);
  }

  Future<void>_signUpWithemailAndPassword(SignUpEvent event, Emitter<AuthState> emit)async{
    final res = await _authUseCase(
      SignUpParams(
        email: event.email, 
        password: event.password, 
        firstName: event.firstName, 
        lastName: event.lastName, 
        fullName: event.fullName, 
        bio: event.bio,
        profileImageUrl: event.profileImageUrl, 
        coverPhotoUrl: event.coverPhotoUrl, 
        followers: event.followers, 
        following: event.following,
      )
    );

    res.fold(
      (l){
        emit(state.copyWith(message: l.message.toString(),uiStatus: UiStatus.error));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text(BlocProvider.of<AuthBloc>(event.context).state.message)));
      },
      (r){
        List<UserEntities> userData = [];
        userData.add(r);
        emit(state.copyWith(message: 'Sucess',userData: userData,uiStatus: UiStatus.success));
      }
    );
    Navigator.pop(event.context);
  }
}
