// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/user_profile/domain/usecase/user_profile_data_usecase.dart';
import 'package:wemet/features/user_profile/domain/usecase/user_profile_post_usecase.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {

  final UserProfileDataUsecase _userProfileDataUsecase;
  final UserProfilePostUsecase _userProfilePostUsecase;

  UserProfileBloc({
    required UserProfileDataUsecase userProfileDataUsecase,
    required UserProfilePostUsecase userProfilePostUsecase,
  }) : _userProfileDataUsecase = userProfileDataUsecase,
    _userProfilePostUsecase = userProfilePostUsecase,
    super(const UserProfileState()) {
    on<UserProfileDataEvent>(_getUserProfileData);
  }

  Future<void> _getUserProfileData(UserProfileDataEvent event, Emitter<UserProfileState> emit) async{
    
    final dataResponse =  await _userProfileDataUsecase(UserParamsData(email: event.email));
    dataResponse.fold(
      (l) => emit(state.copyWith(message: l.message,uiStatus: UiStatus.error)), 
      (r) => emit(state.copyWith(userprofileData: r,uiStatus: UiStatus.success)),
    );

    final postResponse = await _userProfilePostUsecase(UserParamsPost(email: event.email));
    postResponse.fold(
      (l){
        emit(state.copyWith(message: l.message,uiStatus: UiStatus.error));
        Navigator.pop(event.context);
      }, 
      (r){
        emit(state.copyWith(userProfilePost: r,uiStatus: UiStatus.success));
        Navigator.pop(event.context);
        GoRouter.of(event.context).pushNamed(AppRoutesConstant.userprofile);
      }
    );
  }
}
