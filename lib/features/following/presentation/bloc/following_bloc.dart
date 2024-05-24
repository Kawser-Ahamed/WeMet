// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/features/following/domain/entities/following_entities.dart';
import 'package:wemet/features/following/domain/usecase/add_following_usecase.dart';
import 'package:wemet/features/following/domain/usecase/fetch_following_usecase.dart';
import 'package:wemet/features/following/domain/usecase/remove_following_usecase.dart';
import 'package:wemet/features/following/presentation/bloc/following_event.dart';
import 'package:wemet/features/following/presentation/bloc/following_state.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {

  final AddFollowingUsecase _addFollowingUsecase;
  final FetchFollowingUsecase _fetchFollowingUsecase;
  final RemoveFollowingUsecase _removeFollowingUsecase;
  FollowingBloc({
    required AddFollowingUsecase addFollowingUsecase,
    required FetchFollowingUsecase fetchFollowingUsecase,
    required RemoveFollowingUsecase removeFollowingUsecase,
  }) : 
    _addFollowingUsecase = addFollowingUsecase,
    _fetchFollowingUsecase = fetchFollowingUsecase,
    _removeFollowingUsecase = removeFollowingUsecase,
    super(const FollowingState()) {
    on<AddFollowingEvent>(_addFollowing);
    on<FetchFollowingEvent>(_fetchFollowingData);
    on<RemoveFollowingEvent>(_removeFollowing);
  }

  Future<void> _addFollowing(AddFollowingEvent event, Emitter<FollowingState> emit) async{
    final response = await _addFollowingUsecase(
      FollowingEntities(
        userEmail: event.userEmail, 
        followingEmail: event.followingEmail,
      )
    );
    response.fold(
      (l) => emit(state.copyWith(message: l.message)), 
      (r){
        emit(state.copyWith(message: r));
        event.context.read<FollowingBloc>().add(FetchFollowingEvent(email: event.userEmail));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('${state.message} ${event.fullName}')));
      }
    );
    event.context.read<AuthBloc>().add(UserDataEvent(email: event.userEmail, context: event.context, isView: false));
    event.context.read<UserProfileBloc>().add(UserProfileDataEvent(email: event.followingEmail,isView: false,context: event.context));
  } 

  Future<void> _fetchFollowingData(FetchFollowingEvent event, Emitter<FollowingState> emit) async{
    final response = await _fetchFollowingUsecase(UsersFollowingParams(email: event.email));
    response.fold(
      (l) => emit(state.copyWith(message: l.message,uiStatus: UiStatus.error)), 
      (r){
        emit(state.copyWith(uiStatus: UiStatus.success,followingUserMap: r));
      }
    );
  }

  Future<void> _removeFollowing(RemoveFollowingEvent event, Emitter<FollowingState> emit) async{
    final response = await _removeFollowingUsecase(
      FollowingEntities(
        userEmail: event.userEmail, 
        followingEmail: event.followingEmail,
      )
    );
    response.fold(
      (l) => emit(state.copyWith(message: l.message)), 
      (r){
        emit(state.copyWith(message: r));
        event.context.read<FollowingBloc>().add(FetchFollowingEvent(email: event.userEmail));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('${state.message} ${event.fullName}')));
      }
    );
    event.context.read<AuthBloc>().add(UserDataEvent(email: event.userEmail, context: event.context, isView: false));
    event.context.read<UserProfileBloc>().add(UserProfileDataEvent(email: event.followingEmail,isView: false,context: event.context));
  } 
}
