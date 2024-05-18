import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

class CommentLoading extends StatelessWidget {
  const CommentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          height: height * 0.2,
          width: width * 1,
          margin: EdgeInsets.symmetric(vertical: height * 0.01,horizontal: width * 0.03),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular((width/Screen.designWidth) * 20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
            child: Column(
              children: [
               Row(
                  children: [
                    CircleAvatar(
                      radius: height * 0.04,
                      backgroundColor: Colors.grey.shade500,
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.02,
                            width: width,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            height: height * 0.02,
                            width: width,
                            color: Colors.grey.shade500,
                          )
                        ],
                      )
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  height: height * 0.05,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: BorderRadius.circular((width/Screen.designWidth)*10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}