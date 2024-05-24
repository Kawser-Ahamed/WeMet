import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/Color/app_color.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/features/auth/presentation/widget/custom_textfield.dart';
import 'package:wemet/features/auth/presentation/widget/forgot_password_dialog.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColor.signinPageRedbackgroundColor,AppColor.signinPageDarkbackgroundColor]),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: height * 0.15,
                  width: height * 0.15,
                  margin: EdgeInsets.only(top: height * 0.07),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(screenFactor * 10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                  child: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.03),
                      child: Image.asset(AppImageUrls.appIcon)),
                  ),
                ),
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
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.03),
                          Center(
                            child: Text("Welcome Back",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.aBeeZee(
                                fontSize: screenFactor *50,
                                fontWeight : FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: CustomTextField(label: "Email", prefixIcon: Icons.email,controller: emailController,isPassword: false,)
                          ),
                          SizedBox(height: height * 0.02),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: CustomTextField(label: "Password", prefixIcon: Icons.password,controller: passwordController,isPassword: true,)
                          ),
                          SizedBox(height: height * 0.02),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Row(
                              children: [
                                Text("Don't Have Any Account?  ",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: screenFactor *30,
                                    fontWeight : FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    GoRouter.of(context).pushNamed(AppRoutesConstant.signUp);
                                  },
                                  child: Text("Sign Up",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: screenFactor *30,
                                      color: Colors.green,
                                      fontWeight : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.02),
                            child: TextButton(
                              onPressed: (){
                                forgotPasswordDialog(context);
                              }, 
                              child: Text("Forgot Password?",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: screenFactor *30,
                                  color: Colors.red,
                                  fontWeight : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          GestureDetector(
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                context.read<AuthBloc>().add(SignInEvent(email: emailController.text, password: passwordController.text, context: context));
                                mainLoading(context);
                              }
                            },
                            child:Container(
                              width: width,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(screenFactor * 10),
                                gradient: LinearGradient(colors: [AppColor.signinPageRedbackgroundColor,AppColor.signinPageDarkbackgroundColor]),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.015),
                                child: Text("Sign In",
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.white,
                                    fontSize: screenFactor * 35,
                                    fontWeight : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Text("© 2024 WeMet. All rights reserved by Kawser Ahamed.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.aBeeZee(
                                fontSize: screenFactor *30,
                                color: Colors.black,
                                fontWeight : FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}