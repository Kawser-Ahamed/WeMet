import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/Color/app_color.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';
import 'package:wemet/features/auth/presentation/widget/custom_textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColor.signinPageRedbackgroundColor,AppColor.signinPageDarkbackgroundColor]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: height * 0.1,
              left: width * 0.37,
              height: height * 0.15,
              width: height * 0.15,
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(screenFactor * 10)),
                  elevation: 10.0,
                  shadowColor: Colors.grey.shade300,
                  child: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.03),
                      child: Image.asset(AppImageUrls.appIcon)),
                  ),
                ),
              )
            ),
            Positioned(
              top: height * 0.3,
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenFactor * 30),
                  topRight: Radius.circular(screenFactor * 30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.03),
                      Text("Welcome Back",
                        style: GoogleFonts.aBeeZee(
                          fontSize: screenFactor *50,
                          fontWeight : FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      CustomTextField(label: "Email", prefixIcon: Icons.email,controller: emailController,isPassword: false,),
                      SizedBox(height: height * 0.02),
                      CustomTextField(label: "Password", prefixIcon: Icons.password,controller: passwordController,isPassword: true,),
                      SizedBox(height: height * 0.03),
                      Material(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(screenFactor *10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.015,horizontal: width * 0.38),
                          child: Text("Login",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: screenFactor * 35,
                              fontWeight : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: width * 0.05),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: height * 0.002,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("OR",
                            textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenFactor * 35,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: height * 0.002,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: width * 0.05),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Material(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(screenFactor * 10),
                          child: Padding(
                            padding: EdgeInsets.only(right: width * 0.15,top: width * 0.01,bottom: width * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: width * 0.1,
                                  width: width * 0.1,
                                  margin: EdgeInsets.only(left: width * 0.01),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(screenFactor* 10),
                                  ),
                                  child: FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.1),
                                      child: Image.asset(AppImageUrls.googleIcon)
                                    ),
                                  ),
                                ),
                                Text("Sign In With Google",
                                  style: TextStyle(
                                    fontSize: screenFactor * 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}