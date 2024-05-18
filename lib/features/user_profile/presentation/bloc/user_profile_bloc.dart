import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(const UserProfileState()) {
    on<UserProfileDataEvent>(_getUserProfileData);
    on<UserprofilePostEvent>(_getUserProfilePosts);
  }

  Future<void> _getUserProfileData(UserProfileDataEvent event, Emitter<UserProfileState> state) async{

  }
  Future<void> _getUserProfilePosts(UserprofilePostEvent event, Emitter<UserProfileState> state) async{

  }
}
