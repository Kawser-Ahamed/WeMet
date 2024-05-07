import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/widget/custom_textfield.dart';

class UserNameDesign extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  const UserNameDesign({super.key, required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Whats Your Name",
          style: GoogleFonts.actor(
            fontSize: screenFactor *40,
            color: Colors.black,
            fontWeight : FontWeight.w600,
          ),
        ),
        Text("Please enter your original name.This name will be visible for everyone.",
          style: GoogleFonts.actor(
            fontSize: screenFactor *30,
            color: Colors.black,
            fontWeight : FontWeight.normal,
          ),
        ),
        SizedBox(height: height * 0.03),
       Row(
        children: [
          Expanded(
            child: CustomTextField(label: "First Name", prefixIcon: Icons.person, controller: firstName, isPassword: false)
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: CustomTextField(label: "Last Name", prefixIcon: Icons.person, controller: lastName, isPassword: false)
          ),
        ],
       )
      ],
    );
  }
}