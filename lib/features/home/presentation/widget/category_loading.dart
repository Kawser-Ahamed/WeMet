import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return SingleChildScrollView(
      physics: const  NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.background,
          child: Row(
            children: List.generate(
              20, (index) => Container(
                height: height * 0.05,
                width: width * 0.25,
                margin: EdgeInsets.only(left: width * 0.03),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  //border: Border.all(),
                  borderRadius: BorderRadius.circular((width/Screen.designWidth) * 30),
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}