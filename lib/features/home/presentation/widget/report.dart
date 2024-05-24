import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

reportDialogue(BuildContext context){
  double height = Screen.screenHeight(context);
  double width = Screen.screenWidth(context);
  return showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.02),
          child: Text("Thanks for your feedback.",
            style: TextStyle(
              fontSize: (width/Screen.designWidth) * 30,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Text("OK",
            style: TextStyle(
              fontSize: (width/Screen.designWidth) * 30,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
        ],
      );
    },
  );
}