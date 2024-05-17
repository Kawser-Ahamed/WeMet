import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/profile/domain/usecase/profile_usecase.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_event.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final ProfileUsecase _profileUsecase;
  ProfileBloc({
    required ProfileUsecase profileUsecase,
  }) :_profileUsecase= profileUsecase, super(const ProfileState()) {
    on<ProfileDataEvent>(_getProfileData);
  }

  Future<void> _getProfileData(ProfileDataEvent event, Emitter<ProfileState> emit) async{
    final response = await _profileUsecase(ProfileParam(email: event.email));
    response.fold(
      (l) => emit(state.copyWith(uiStatus: UiStatus.error,message: l.message)), 
      (r) => emit(state.copyWith(uiStatus: UiStatus.success,profileData: r)),
    );
  }
}
