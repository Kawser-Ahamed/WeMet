// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/features/edit_profile/domain/entities/edit_profile_entities.dart';
import 'package:wemet/features/edit_profile/domain/usecase/edit_cover_photo_usecase.dart';
import 'package:wemet/features/edit_profile/domain/usecase/edit_profile_picture_usecase.dart';
import 'package:wemet/features/edit_profile/domain/usecase/edit_profile_usecase.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_event.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUsecase _editProfileUsecase;
  final EditprofilePictureUsecase _editprofilePictureUsecase;
  final EditCoverPhotoUsecase _editCoverPhotoUsecase;
  EditProfileBloc({
    required EditProfileUsecase editProfileUsecase,
    required EditprofilePictureUsecase editprofilePictureUsecase,
    required EditCoverPhotoUsecase editCoverPhotoUsecase,
  }) : _editProfileUsecase = editProfileUsecase, 
    _editprofilePictureUsecase = editprofilePictureUsecase,
    _editCoverPhotoUsecase = editCoverPhotoUsecase,
    super(const EditProfileState()) {
    on<EditProfileDataEvent>(_updateProfile);
    on<EditProfilePictureEvent>(_editProfilePicture);
    on<EditCoverPhotoEvent>(_editCoverPhoto);
  }

  Future<void> _updateProfile(EditProfileDataEvent event, Emitter<EditProfileState> emit) async{
    final response = await _editProfileUsecase(
      EditProfileEntities(
        fullName: event.fullName, 
        bio: event.bio, 
        email: event.email,
      )
    );
    response.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r){
        emit(state.copyWith(message: r));
        event.context.read<AuthBloc>().add(UserDataEvent(email: event.email, context: event.context));
        event.context.read<ProfileBloc>().add(ProfileDataEvent(email: event.email));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(state.message)));
      },
    );
  }

  Future<void> _editProfilePicture(EditProfilePictureEvent event, Emitter<EditProfileState> emit) async{
    final response = await _editprofilePictureUsecase(ProfilePictureParams(profilePicture: event.profilePicture,email: event.email));
    response.fold(
      (l) => emit(state.copyWith(message: l.message)), 
      (r){
        emit(state.copyWith(message: r));
        event.context.read<AuthBloc>().add(UserDataEvent(email: event.email, context: event.context));
        event.context.read<ProfileBloc>().add(ProfileDataEvent(email: event.email));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(state.message)));
      }
    );
  }

  Future<void> _editCoverPhoto(EditCoverPhotoEvent event, Emitter<EditProfileState> emit) async{
    final response = await _editCoverPhotoUsecase(CoverPhotoParams(coverPhoto: event.coverPhoto,email: event.email));
    response.fold(
      (l) => emit(state.copyWith(message: l.message)), 
      (r){
        emit(state.copyWith(message: r));
        event.context.read<AuthBloc>().add(UserDataEvent(email: event.email, context: event.context));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(state.message)));
      }
    );
  }

}
