import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  const SearchTextField({super.key, required this.controller});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}
class _SearchTextFieldState extends State<SearchTextField> {

  bool obsecure = true;
  
  @override
  Widget build(BuildContext context) {
    //double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(
          //color: Colors.black,
          fontSize: (width/Screen.designWidth) * 30,
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
    );
  }
}