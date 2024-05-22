// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/features/following/domain/entities/following_entities.dart';
import 'package:wemet/features/following/domain/usecase/add_following_usecase.dart';
import 'package:wemet/features/following/presentation/bloc/following_event.dart';
import 'package:wemet/features/following/presentation/bloc/following_state.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {

  final AddFollowingUsecase _addFollowingUsecase;
  
  FollowingBloc({
    required AddFollowingUsecase addFollowingUsecase,
  }) : 
    _addFollowingUsecase = addFollowingUsecase,
    super(const FollowingState()) {
    on<AddFollowingEvent>(_addFollowing);
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
        event.context.read<AuthBloc>().add(UserDataEvent(email: event.userEmail, context: event.context));
        event.context.read<UserProfileBloc>().add(UserProfileDataEvent(event.followingEmail, event.context));
      }
    );
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('${state.message} ${event.followingEmail}')));
    Navigator.pop(event.context);
  } 
}
