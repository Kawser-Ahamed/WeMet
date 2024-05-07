import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/widget/custom_textfield.dart';

class EmailPasswordDesign extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const EmailPasswordDesign({super.key, required this.emailController, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email & Password",
          style: GoogleFonts.actor(
            fontSize: screenFactor *40,
            color: Colors.black,
            fontWeight : FontWeight.w600,
          ),
        ),
        Text("Please enter your email & password.So that you can use that email & password next time to signin WeMet.",
          style: GoogleFonts.actor(
            fontSize: screenFactor *30,
            color: Colors.black,
            fontWeight : FontWeight.normal,
          ),
        ),
        SizedBox(height: height * 0.03),
        CustomTextField(label: "Email", prefixIcon: Icons.mail, controller: emailController, isPassword: false),
        SizedBox(height: height * 0.02,),
        CustomTextField(label: "Password", prefixIcon: Icons.password, controller: passwordController, isPassword: true),
      ],
    );
  }
}