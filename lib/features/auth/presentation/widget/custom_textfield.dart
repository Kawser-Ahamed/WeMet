import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  const CustomTextField({super.key, required this.label, required this.prefixIcon, required this.controller, required this.isPassword});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}
class _CustomTextFieldState extends State<CustomTextField> {

  bool obsecure = true;
  
  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: TextField(
        controller: widget.controller,
        obscureText: (widget.isPassword) ? obsecure : false,
        decoration: InputDecoration(
          label: Text(widget.label,
            style: TextStyle(
              fontSize: (width/Screen.designWidth) * 30,
            ),
          ),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: (widget.isPassword) ? InkWell(
            onTap: (){
              setState(() {
                obsecure = !obsecure;
              });
            },
            child: (obsecure) ? Icon(Icons.visibility,color: Colors.black,size:(width/Screen.designWidth) * 40) : Icon(Icons.visibility_off,color: Colors.black, size: (width/Screen.designWidth) * 40),
          ) : null,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}