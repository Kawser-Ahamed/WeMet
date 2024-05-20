import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const EditTextField({super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    return TextField(
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        labelText: "Full Name",
        hintStyle: TextStyle(
          fontSize: (width/Screen.designWidth) * 30,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular((width/Screen.designWidth)*10),
          borderSide: const BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((width/Screen.designWidth)*10),
          borderSide: const BorderSide(
            color: Colors.blue,
          )
        ),
      ),
    );
  }
}