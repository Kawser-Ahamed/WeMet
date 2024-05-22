// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';
import 'package:wemet/features/auth/domain/usecase/signin_usecase.dart';
import 'package:wemet/features/auth/domain/usecase/signup_usecase.dart';
import 'package:wemet/features/auth/domain/usecase/user_usecase.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signupUseCase;
  final SignInUseCase _signinUseCase;
  final UserUsecase _userUseCase;
  AuthBloc({
    required SignUpUseCase signupUseCase,
    required SignInUseCase singInUseCase,
    required UserUsecase userUsecase,
  }) : _signupUseCase = signupUseCase,
    _signinUseCase = singInUseCase, 
    _userUseCase = userUsecase,
    super(const AuthState()) {
    on<SignUpEvent>(_signUpWithEmailAndPassword);
    on<SignInEvent>(_signInWithEmailAndPassWord);
    on<UserDataEvent>(_getUserData);
  }

  Future<void>_signUpWithEmailAndPassword(SignUpEvent event, Emitter<AuthState> emit)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
        event.context.read<ProfileBloc>().add(ProfileDataEvent(email: state.userData.first.email));
        sharedPreferences.setString('email', event.email);
        GoRouter.of(event.context).pushNamed(AppRoutesConstant.mainPage);
      }
    );
    Navigator.pop(event.context);
  }

  Future<void> _signInWithEmailAndPassWord(SignInEvent event, Emitter<AuthState> emit) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await _signinUseCase(SignInParams(email: event.email, password: event.password));
    response.fold(
      (l){
        emit(state.copyWith(message: l.message.toString(),uiStatus: UiStatus.error));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text(BlocProvider.of<AuthBloc>(event.context).state.message)));
      }, 
      (r){
        emit(state.copyWith(message: 'Successfull',userData: r,uiStatus: UiStatus.success));
        event.context.read<ProfileBloc>().add(ProfileDataEvent(email: state.userData.first.email));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text(BlocProvider.of<AuthBloc>(event.context).state.userData.first.fullName)));
        sharedPreferences.setString('email', event.email);
        GoRouter.of(event.context).pushNamed(AppRoutesConstant.mainPage);
      }
    );
    Navigator.pop(event.context);
  }

  Future<void> _getUserData(UserDataEvent event, Emitter<AuthState> emit) async{
    final response = await _userUseCase(UserEmailParams(email: event.email));
    response.fold(
      (l) => emit(state.copyWith(uiStatus: UiStatus.error,message: l.message)), 
      (r){
        emit(state.copyWith(userData: r,uiStatus: UiStatus.success));
        event.context.read<ProfileBloc>().add(ProfileDataEvent(email: state.userData.first.email));
       if(event.isView){
          GoRouter.of(event.context).pushNamed(AppRoutesConstant.mainPage);
       }
      },
    );
  }
}
