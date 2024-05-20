import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemet/config/theme/bloc/theme_event.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light){
    on<UserChangeThemeEvent>(_changeTheme);
    on<PrimaryChangeThemeEvent>(_primaryChangeTheme);
  }

  _changeTheme(UserChangeThemeEvent event, Emitter<ThemeMode> emit) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(event.isDark){
      sharedPreferences.setBool('theme', true);
    }
    else{
      sharedPreferences.setBool('theme', false);
    }
    emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _primaryChangeTheme(PrimaryChangeThemeEvent event, Emitter<ThemeMode> emit) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var theme = sharedPreferences.getBool('theme'); 
    if(theme == null){
      emit(ThemeMode.light);
    }
    else if(theme){
      emit(ThemeMode.dark);
    }
    else{
      emit(ThemeMode.light);
    }
  }

}


