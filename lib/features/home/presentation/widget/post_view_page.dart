import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:photo_view/photo_view.dart';

class PostViewPage extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String profileImage;
  final String dateTime;
  final String caption;
  const PostViewPage({super.key, required this.imageUrl, required this.profileImage, required this.caption, required this.name, required this.dateTime});

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        width: width,
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: PhotoView(
                imageProvider: NetworkImage(widget.imageUrl),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.03,right: width * 0.03,top: height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: height * 0.06,
                        width: height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: const Icon(Icons.arrow_back,color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: height * 0.03,
                              backgroundImage: NetworkImage(widget.profileImage),
                            ),
                            SizedBox(width: width * 0.03),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.name,
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white,
                                      fontSize: screenFactor * 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(widget.dateTime,
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white,
                                      fontSize: screenFactor * 30,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        ExpandableText(widget.caption, 
                          expandText: "Read more",
                          collapseText: "Read less",
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenFactor * 30,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}