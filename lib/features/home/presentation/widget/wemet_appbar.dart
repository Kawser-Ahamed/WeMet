import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';

class WemetAppBar extends StatefulWidget {
  const WemetAppBar({super.key});

  @override
  State<WemetAppBar> createState() => _WemetAppBarState();
}

class _WemetAppBarState extends State<WemetAppBar> {

  bool active = false;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade500,
            )
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: ListTile(
            leading: Container(
              height: height * 0.2,
              width: width * 0.2,
              color: Colors.transparent,
              child: FittedBox(
                child: Image.asset(AppImageUrls.appIcon),
              ),
            ),
            trailing: Switch(
              value: active, 
              onChanged: (value){
                active = value;
                setState(() {});
              }
            ),
          ),
        ),
      ),
    );
  }
}