import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              color: Theme.of(context).colorScheme.background,
              margin: EdgeInsets.only(bottom: height * 0.02),
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: height * 0.04,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            backgroundColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                          SizedBox(width: width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height * 0.02,
                                  width: width * 1,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                SizedBox(height: height * 0.01),
                                Container(
                                  height: height * 0.02,
                                  width: width * 0.5,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      height: height * 0.25,
                      width: width * 1,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular((width/Screen.designWidth)*10)
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}