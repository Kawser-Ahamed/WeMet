import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';

class FolowingLoading extends StatelessWidget {
  const FolowingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          growable: true,
          10, (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0),
            child: Container(
              width: height * 0.12,
              color: Colors.transparent,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: height * 0.04,
                    backgroundColor: Colors.yellow,
                  ),
                  Text('Followers',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee(
                      fontSize: (width/Screen.designWidth) * 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}