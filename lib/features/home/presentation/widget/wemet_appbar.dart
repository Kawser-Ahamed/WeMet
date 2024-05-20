// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/config/theme/bloc/theme_bloc.dart';
import 'package:wemet/config/theme/bloc/theme_event.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';

class WemetAppBar extends StatefulWidget {
  const WemetAppBar({super.key});

  @override
  State<WemetAppBar> createState() => _WemetAppBarState();
}

class _WemetAppBarState extends State<WemetAppBar> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade500,
          )
        )
      ),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.1,
                width: width * 0.2,
                color: Colors.transparent,
                child: FittedBox(
                  child: Image.asset(AppImageUrls.appIcon),
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.sunny,size: screenFactor * 40,),
                      Switch(
                        activeColor: Colors.green,
                        value: context.read<ThemeBloc>().state == ThemeMode.dark, 
                        onChanged: (value){
                          setState(() {
                            context.read<ThemeBloc>().add(UserChangeThemeEvent(value));
                          });
                        }
                      ),
                      Icon(Icons.mode_night,size: screenFactor * 40,),
                    ],
                  ),
                  SizedBox(width: width * 0.03),
                  InkWell(
                    onTap: () async{
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.remove('email');
                      GoRouter.of(context).pushNamed(AppRoutesConstant.signIn);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.logout,color: Colors.red,size: screenFactor * 50),
                        Text("Logout",
                          style: TextStyle(
                            fontSize: screenFactor * 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}