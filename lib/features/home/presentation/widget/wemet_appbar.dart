// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';

class WemetAppBar extends StatefulWidget {
  const WemetAppBar({super.key});

  @override
  State<WemetAppBar> createState() => _WemetAppBarState();
}

class _WemetAppBarState extends State<WemetAppBar> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade500,
          )
        )
      ),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.1,
                width: width * 0.2,
                color: Colors.transparent,
                child: FittedBox(
                  child: Image.asset(AppImageUrls.appIcon),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}