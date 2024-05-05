import 'package:flutter/material.dart';
import 'package:wemet/core/Color/app_color.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/loading.dart';
import 'package:wemet/core/urls/app_image_urls.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImageUrls.appLogo,fit: BoxFit.contain),
          Loading(color: Colors.white, size: width * 0.1),
        ], 
      ),
    );
  }
}