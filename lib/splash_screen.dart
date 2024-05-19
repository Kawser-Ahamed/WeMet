// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/Color/app_color.dart';
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
        GoRouter.of(context).pushNamed(AppRoutesConstant.signIn);
      });
    }
    else{
      context.read<AuthBloc>().add(UserDataEvent(email: email, context: context));
    }
  }

  @override
  void initState() {
    _getAuthenticateUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImageUrls.appLogo,fit: BoxFit.contain),
          const Loading(color: Colors.white, size: 0.1),
        ], 
      ),
    );
  }
}