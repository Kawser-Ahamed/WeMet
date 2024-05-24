import 'package:flutter/material.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/Color/app_color.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      body:Stack(
        children: [
           PageView(
            controller: _pageController,
            onPageChanged: (value){
              setState(() {
                _currentIndex = value;
              });
            },
            children: [
              Container(
                height: height,
                width: width,
                color: AppColor.welcomePageBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.05),
                    Image.asset(AppImageUrls.welcomeScreenFirstImage,fit: BoxFit.contain,height: height * 0.4),
                    Text("Welcome To WeMet",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontSize: (width/Screen.designWidth) * 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text("Here we meet with strangers & they turn into friends!!!.",
                      textAlign: TextAlign.center,
                        style: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontSize: (width/Screen.designWidth) * 40,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height,
                width: width,
                color: AppColor.welcomePageSecondBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.05),
                    Image.asset(AppImageUrls.welcomeScreenSecondImage,fit: BoxFit.contain,height : height * 0.4),
                    Text("Connect With Others",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: (width/Screen.designWidth) * 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text("Connect & see post of worldwide friend's.Let's go...",
                      textAlign: TextAlign.center,
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: (width/Screen.designWidth) * 40,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height,
                width: width,
                color: AppColor.welcomePageThirdBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.05),
                    Image.asset(AppImageUrls.welcomeScreenThirdImage,fit: BoxFit.contain,height: height * 0.4,),
                    Text("Let's Explore WeMet",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: (width/Screen.designWidth) * 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text("Status,News,Advertisement all in one app.",
                      textAlign: TextAlign.center,
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: (width/Screen.designWidth) * 40,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: height * 0.1),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PageViewIndicator(
                currentIndex: _currentIndex,
                currentSize: (width/Screen.designWidth) * 20,
                otherSize: (width/Screen.designWidth) * 15,
                currentColor: Colors.red,
                length: 3,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: (){
          _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
        },
        child: Card(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1,vertical: height * 0.01),
            child: (_currentIndex < 2) ? Text("Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: (width/Screen.designWidth) * 30,
              ),
            ) : InkWell(
              onTap: (){
                GoRouter.of(context).pushNamed(AppRoutesConstant.signIn);
              },
              child: Text("Start",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (width/Screen.designWidth) * 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}