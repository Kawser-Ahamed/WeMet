import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/edit_profile/presentation/widgets/edit_cover_photo.dart';
import 'package:wemet/features/edit_profile/presentation/widgets/edit_profile_picture.dart';

class EditPicture extends StatefulWidget {
  final String pictureType;
  final String imageUrl;
  const EditPicture({super.key,required this.pictureType,required this.imageUrl});

  @override
  State<EditPicture> createState() => _EditPictureState();
}

class _EditPictureState extends State<EditPicture> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade500),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.arrow_back,size: screenFactor * 60),
                  ),
                  Text("Edit ${widget.pictureType}",
                    style: GoogleFonts.aBeeZee(
                      fontSize: screenFactor * 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      GoRouter.of(context).pushNamed(AppRoutesConstant.search);
                    }, 
                    icon: Icon(Icons.search,size: screenFactor * 60),
                  ),
                ],
              ),
            ),
          ),
          (widget.pictureType == "Profile Picture") ? 
          Expanded(child:EditProfilePicture(imageUrl: widget.imageUrl,)) :
          Expanded(child: EditCoverPhoto(imageUrl: widget.imageUrl,)),
        ],
      ),
    );
  }
}