// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/config/theme/bloc/theme_bloc.dart';
import 'package:wemet/config/theme/bloc/theme_event.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/loading.dart';
import 'package:wemet/core/urls/app_image_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _getAuthenticateUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString('email');
    if(email==null){
      Timer(const Duration(seconds: 2), () {
        GoRouter.of(context).pushNamed(AppRoutesConstant.welcomePage);
      });
    }
    else{
      context.read<ThemeBloc>().add(PrimaryChangeThemeEvent());
      context.read<AuthBloc>().add(UserDataEvent(email: email,isView: true, context: context));
    }
  }

  @override
  void initState() {
    _getAuthenticateUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.2,
            width: width * 0.4,
            child: Image.asset(AppImageUrls.appIcon,fit: BoxFit.contain),
          ),
          SizedBox(height: height * 0.02),
          const Loading(color: Colors.white, size: 0.1),
        ], 
      ),
    );
  }
}