import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/widget/custom_textfield.dart';

forgotPasswordDialog(BuildContext context){
  //double height = Screen.screenHeight(context);
  double width = Screen.screenWidth(context);
  double screenFactor = width/Screen.designWidth;
  TextEditingController emailcontroller = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor:  Colors.white,
        title: Text("Reset your Password",
          style: TextStyle(
            fontSize: screenFactor * 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomTextField(label: "Email", prefixIcon: Icons.mail, controller: emailcontroller, isPassword: false),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Text("Cancel",
              style: TextStyle(
                fontSize: screenFactor * 30,
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: (){
              FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text)
              .then((value){
                Navigator.pop(context);
                resetMessageDialog(context);
              });
            }, 
            child: Text("Reset",
              style: TextStyle(
                fontSize: screenFactor * 30,
                color: Colors.green,
              ),
            ),
          ),
        ],
      );
    },
  );
}

resetMessageDialog(BuildContext context){
  double height = Screen.screenHeight(context);
  double width = Screen.screenWidth(context);
  double screenFactor = width/Screen.designWidth;
  return showDialog(
    context: context, 
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("WeMet",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenFactor * 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content:Text("We have send you a email to reset password. Please check it & reset your password.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenFactor * 30,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: Text("Ok",
                style: TextStyle(
                  fontSize: screenFactor * 30,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}