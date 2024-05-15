import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

class UploadPostTextField extends StatelessWidget {
  final TextEditingController captionController;
  const UploadPostTextField({super.key, required this.captionController});

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    return TextField(
      maxLines: null,
      controller: captionController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.emoji_emotions,size: (width/Screen.designWidth) * 50,color: Colors.yellow),
        hintText: "What's On Your Mind?",
        hintStyle: TextStyle(
          fontSize: (width/Screen.designWidth) * 30,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          )
        ),
      ),
    );
  }
}