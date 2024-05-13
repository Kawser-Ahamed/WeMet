import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/config/theme/bloc/theme_event.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light){
    on<ThemeEvent>(_changeTheme);
  }

  _changeTheme(ThemeEvent event, Emitter<ThemeMode> emit){
    emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
  }

}


