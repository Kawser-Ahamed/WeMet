import 'package:flutter_bloc/flutter_bloc.dart';
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

  _signUpWithemailAndPassword(SignUpEvent event, Emitter<AuthState> emit)async{
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
      (l) => emit(state.copyWith(message: l.toString())), 
      (r) => emit(state.copyWith(message: r.fullName)),
    );
  }
}
