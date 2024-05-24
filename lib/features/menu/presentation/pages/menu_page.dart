// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/config/theme/bloc/theme_bloc.dart';
import 'package:wemet/config/theme/bloc/theme_event.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade500),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  SizedBox(
                    height: height * 0.1,
                    width: width * 0.3,
                    child: Image.asset(AppImageUrls.appIcon),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    InkWell(
                      onTap: (){
                        Share.share("Download WeMet App\nhttps://drive.google.com/file/d/1MDbLM4pEP1sCbQrdlRFW5NdWtaX8cvud/view?usp=drive_link");
                      },
                      child: Container(
                        width: width * 1,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(screenFactor * 10),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.onPrimary,
                              blurRadius: 2,spreadRadius: 2,
                            )
                          ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Invite your friends",
                                style: TextStyle(
                                  fontSize: screenFactor * 30,
                                ),
                              ),
                              Icon(Icons.share,size: screenFactor * 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width * 1,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(screenFactor * 10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onPrimary,
                            blurRadius: 2,spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Dark mode",
                              style: TextStyle(
                                fontSize: screenFactor * 30,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.sunny,size: screenFactor * 40,),
                                Transform.scale(
                                  scale: screenFactor * 1.7,
                                  child: Switch(
                                    activeColor: Colors.green,
                                    value: context.read<ThemeBloc>().state == ThemeMode.dark, 
                                    onChanged: (value){
                                      setState(() {
                                        context.read<ThemeBloc>().add(UserChangeThemeEvent(value));
                                      });
                                    }
                                  ),
                                ),
                                Icon(Icons.mode_night,size: screenFactor * 40,),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width * 1,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(screenFactor * 10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onPrimary,
                            blurRadius: 2,spreadRadius: 2,
                          )
                        ],
                      ),
                      child: ExpansionTile(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        title: Text("About",
                          style: TextStyle(
                            fontSize: screenFactor * 30,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        children: [
                          ListTile(
                            title: Text("WeMet v1.0.0",
                              style: TextStyle(
                                fontSize: screenFactor * 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("© 2024 WeMet. All rights reserved by Kawser Ahamed.",
                              style: TextStyle(
                                fontSize: screenFactor * 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("Email: kawserahamed864@gmail.com",
                              style: TextStyle(
                                fontSize: screenFactor * 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    InkWell(
                      onTap: () async{
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.remove('email');
                        GoRouter.of(context).pushNamed(AppRoutesConstant.signIn);
                      },
                      child: Container(
                        width: width * 1,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(screenFactor * 10),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.onPrimary,
                              blurRadius: 2,spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Logout",
                                style: TextStyle(
                                  fontSize: screenFactor * 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Icon(Icons.logout,color: Colors.red,size: screenFactor * 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        ],
      )
    );
  }
}