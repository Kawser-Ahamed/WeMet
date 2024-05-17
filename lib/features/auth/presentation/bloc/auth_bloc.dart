// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';
import 'package:wemet/features/auth/domain/usecase/signin_usecase.dart';
import 'package:wemet/features/auth/domain/usecase/signup_usecase.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signupUseCase;
  final SignInUseCase _signinUseCase;
  AuthBloc({
    required SignUpUseCase signupUseCase,
    required SignInUseCase singInUseCase,
  }) : _signupUseCase = signupUseCase,_signinUseCase=singInUseCase, super(const AuthState()) {
    on<SignUpEvent>(_signUpWithemailAndPassword);
    on<SignInEvent>(_signInWithEmailAndPassWord);
  }

  Future<void>_signUpWithemailAndPassword(SignUpEvent event, Emitter<AuthState> emit)async{
    final res = await _signupUseCase(
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
        GoRouter.of(event.context).pushNamed(AppRoutesConstant.mainPage);
      }
    );
    Navigator.pop(event.context);
  }

  Future<void> _signInWithEmailAndPassWord(SignInEvent event, Emitter<AuthState> emit) async{
    final response = await _signinUseCase(SignInParams(email: event.email, password: event.password));
    response.fold(
      (l){
        emit(state.copyWith(message: l.message.toString(),uiStatus: UiStatus.error));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text(BlocProvider.of<AuthBloc>(event.context).state.message)));
      }, 
      (r){
        emit(state.copyWith(message: 'Successfull',userData: r,uiStatus: UiStatus.success));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text(BlocProvider.of<AuthBloc>(event.context).state.userData.first.fullName)));
        event.context.read<ProfileBloc>().add(ProfileDataEvent(email: state.userData.first.email));
        GoRouter.of(event.context).pushNamed(AppRoutesConstant.mainPage);
      }
    );
    Navigator.pop(event.context);
  }
}
