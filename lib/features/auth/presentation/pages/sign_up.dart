import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/wemet_image_picker.dart';
import 'package:wemet/features/auth/presentation/widget/signup/bio_gender_design.dart';
import 'package:wemet/features/auth/presentation/widget/signup/email_password_design.dart';
import 'package:wemet/features/auth/presentation/widget/signup/user_name_design.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController(); 
  final firstName = TextEditingController(); 
  final lastName = TextEditingController(); 
  final bioController = TextEditingController(); 
  WemetImagePicker profilePicture = WemetImagePicker();
  WemetImagePicker coverPhoto = WemetImagePicker();
  int signUpPageWidgetsIndex = 0;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstName.dispose();
    lastName.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    List<Widget> signUpPageWidgets = [
      EmailPasswordDesign(emailController: emailController, passwordController: passwordController),
      UserNameDesign(firstName: firstName, lastName: lastName),
      BioGenderDesign(bioController: bioController,profilePicture: profilePicture,coverPhoto: coverPhoto),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              InkWell(
                onTap: (){
                  if(signUpPageWidgetsIndex==0){
                    GoRouter.of(context).pop();
                  }
                  else{
                    signUpPageWidgetsIndex--;
                    setState(() {
                      
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,size: screenFactor * 40,color: Colors.black,),
                    Text("Back",
                      style: GoogleFonts.actor(
                        fontSize: screenFactor * 40,
                        color: Colors.black,
                        fontWeight : FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.05),
                      Text("Join The Community",
                        style: GoogleFonts.aBeeZee(
                          fontSize: screenFactor *50,
                          color: Colors.black,
                          fontWeight : FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      signUpPageWidgets[signUpPageWidgetsIndex],
                      SizedBox(height: height * 0.05),
                      InkWell(
                        onTap:(){
                          if(signUpPageWidgetsIndex<signUpPageWidgets.length-1){
                            signUpPageWidgetsIndex++;
                          }
                          setState(() {
                            
                          });
                        },
                        child: Material(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(screenFactor * 10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: (signUpPageWidgetsIndex==signUpPageWidgets.length-1) ? width * 0.34 : width * 0.38,vertical: height * 0.01),
                            child: Text((signUpPageWidgetsIndex==signUpPageWidgets.length-1) ? "Sign Up" : "Next",
                              style: GoogleFonts.aBeeZee( 
                                fontSize: screenFactor *40,
                                color: Colors.white,
                                fontWeight : FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}