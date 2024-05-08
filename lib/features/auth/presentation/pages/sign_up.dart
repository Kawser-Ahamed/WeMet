import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/Color/app_color.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/wemet_image_picker.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_event.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';
import 'package:wemet/features/auth/presentation/widget/signup/bio_image_design.dart';
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
  final _fomrKey = GlobalKey<FormState>();
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
      BioImagerDesign(bioController: bioController,profilePicture: profilePicture,coverPhoto: coverPhoto),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        color: AppColor.signUpPagebackgroundColor,
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
                  child: Form(
                    key: _fomrKey,
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
                            if(_fomrKey.currentState!.validate()){
                              if(signUpPageWidgetsIndex<signUpPageWidgets.length-1){
                                signUpPageWidgetsIndex++;
                                setState(() { }); 
                              }
                              else if(signUpPageWidgetsIndex == signUpPageWidgets.length-1){
                                if(profilePicture.imageFromDevice != null && coverPhoto.imageFromDevice != null){
                                  context.read<AuthBloc>().add(SignUpEvent(
                                    email: emailController.text, 
                                    password: passwordController.text, 
                                    firstName: firstName.text, 
                                    lastName: lastName.text, 
                                    fullName: '${firstName.text} ${lastName.text}', 
                                    bio: bioController.text, 
                                    profileImageUrl: profilePicture.imageFromDevice!,
                                    coverPhotoUrl: coverPhoto.imageFromDevice!, 
                                    followers: 0, 
                                    following: 0,
                                  ));
                                  final AuthState state = BlocProvider.of<AuthBloc>(context).state;
                                  print(state.message);
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please pick images"),));
                                }
                              }
                            }
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