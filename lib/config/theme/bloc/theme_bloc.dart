import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/config/theme/bloc/theme_event.dart';
import 'package:wemet/config/theme/bloc/theme_state.dart';
import 'package:wemet/config/theme/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(lightTheme)) {
    on<ChangeThemeEvent>(_toggleTheme); // Corrected typo here
  }

  void _toggleTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) {
    if (state.themeData == lightTheme) {
      emit(ThemeState(lightTheme)); // Emitting a new state directly
    } else {
      emit(ThemeState(darkTheme)); // Emitting a new state directly
    }
  }
}

