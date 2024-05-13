import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/wemet_image_picker.dart';
import 'package:wemet/core/urls/app_image_urls.dart';
import 'package:wemet/features/auth/presentation/widget/custom_textfield.dart';

class BioImagerDesign extends StatefulWidget {
  final TextEditingController bioController;
  final WemetImagePicker profilePicture;
  final WemetImagePicker coverPhoto;
  const BioImagerDesign({super.key, required this.bioController, required this.profilePicture, required this.coverPhoto});

  @override
  State<BioImagerDesign> createState() => _BioImagerDesignState();
}

class _BioImagerDesignState extends State<BioImagerDesign> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bio & Image",
          style: GoogleFonts.actor(
            fontSize: screenFactor *40,
            color: Colors.black,
            fontWeight : FontWeight.w600,
          ),
        ),
        Text("Please enter something about you.So that everyone can know that who you are.",
          style: GoogleFonts.actor(
            fontSize: screenFactor *30,
            color: Colors.black,
            fontWeight : FontWeight.normal,
          ),
        ),
        SizedBox(height: height * 0.03),
        CustomTextField(label: "Add something about you (BIO)", prefixIcon: Icons.add_reaction, controller: widget.bioController, isPassword: false),
        SizedBox(height: height * 0.02),
        Card(
          elevation: 0,
          color: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Please select a image for Profile picture",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontSize: (screenFactor * 25),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.01),
                        (widget.profilePicture.imageFromDevice == null) ? CircleAvatar(
                          radius: height * 0.05,
                          backgroundImage: AssetImage(AppImageUrls.avatar),
                        ) : CircleAvatar(
                          radius: height * 0.05,
                          backgroundImage:  FileImage(widget.profilePicture.imageFromDevice!),
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                widget.profilePicture.pickImageFromCamera().whenComplete((){
                                  setState(() {});
                                });
                              },
                              child: Icon(Icons.camera_alt,size: screenFactor * 60,color: Colors.blueAccent,)
                            ),
                            SizedBox(width: width * 0.05),
                            InkWell(
                              onTap: (){
                                widget.profilePicture.pickImageFromGallery().whenComplete((){
                                  setState(() {});
                                });
                              },
                              child: Icon(Icons.image,size: screenFactor * 60,color: Colors.green,)
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (widget.coverPhoto.imageFromDevice== null) ? Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage(AppImageUrls.imageIcon),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ) :Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: FileImage(widget.coverPhoto.imageFromDevice!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.01),
                        Text("Please select a image for Cover Photo",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                            color: Colors.black,
                            fontSize: (screenFactor * 25),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                widget.coverPhoto.pickImageFromCamera().whenComplete((){
                                  setState(() {});
                                });
                              },
                              child: Icon(Icons.camera_alt,size: screenFactor * 60,color: Colors.blueAccent,)
                            ),
                            SizedBox(width: width * 0.05),
                            InkWell(
                              onTap: (){
                                widget.coverPhoto.pickImageFromGallery().whenComplete((){
                                  setState(() {});
                                });
                              },
                              child: Icon(Icons.image,size: screenFactor * 60,color: Colors.green,)
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}