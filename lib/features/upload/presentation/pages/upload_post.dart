import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wemet/core/Color/app_color.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/core/reusable/wemet_image_picker.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/upload/presentation/bloc/upload_post_bloc.dart';
import 'package:wemet/features/upload/presentation/bloc/upload_post_event.dart';
import 'package:wemet/features/upload/presentation/widget/upload_post_attachment.dart';
import 'package:wemet/features/upload/presentation/widget/upload_post_text_field.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {

  TextEditingController captionController = TextEditingController();
  WemetImagePicker wemetImagePicker = WemetImagePicker();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height * 0.22,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.uploadPagePrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(screenFactor * 100),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    margin: EdgeInsets.only(left: width * 0.8,top: height * 0.02),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.1,
                    margin: EdgeInsets.only(left: width * 0.68,top: height * 0.02),
                    decoration: BoxDecoration(
                      color: AppColor.uploadPageSecondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: height * 0.04,
                    width: width * 0.08,
                    margin: EdgeInsets.only(left: width * 0.77,top: height * 0.11),
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                    width: height * 0.1,
                    child: const FittedBox(
                      child: Icon(Icons.light,color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.12,
            left: width * 0.03,
            child: Container(
              width: width * 0.7,
              decoration: BoxDecoration(
                color: AppColor.uploadPageSecondaryColor,
                borderRadius: BorderRadius.circular(screenFactor * 50),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.05),
                  child: Text("Share Your Thoughts With Others",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.afacad(
                      fontSize: screenFactor * 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ),
          ),
          Positioned(
            top: height * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add a caption",
                        style: TextStyle(
                          fontSize: (screenFactor * 35),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      UploadPostTextField(captionController: captionController,),
                      SizedBox(height: height * 0.01),
                      Text("Attachment",
                        style: TextStyle(
                          fontSize: (screenFactor * 35),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      UploadPostAttachment(wemetImagePicker: wemetImagePicker),
                      SizedBox(height: height * 0.02),
                      InkWell(
                        onTap:(){
                          DateFormat dateFormat =  DateFormat("dd-MM-yyyy HH:mm");
                          String currentDateTime = dateFormat.format(DateTime.now());
                          if(wemetImagePicker.imageFromDevice != null){
                            context.read<UploadPostBloc>().add(
                              UploadPostWithImageByUserEvent(
                                id: DateTime.now().millisecondsSinceEpoch, 
                                caption: captionController.text, 
                                imageUrl: wemetImagePicker.imageFromDevice!,
                                dateTime: currentDateTime,
                                uploaderName: BlocProvider.of<AuthBloc>(context).state.userData.first.fullName, 
                                email: BlocProvider.of<AuthBloc>(context).state.userData.first.email, 
                                uploaderProfilePictureImageUrl: BlocProvider.of<AuthBloc>(context).state.userData.first.profileImageUrl,
                                context: context,
                              ),
                            );
                            captionController.text = "";
                            mainLoading(context);
                          }
                          else if(captionController.text.isNotEmpty){
                            context.read<UploadPostBloc>().add(
                              UploadPostWithoutImageByUserEvent(
                                id: DateTime.now().millisecondsSinceEpoch, 
                                caption: captionController.text,
                                dateTime: currentDateTime,
                                uploaderName: BlocProvider.of<AuthBloc>(context).state.userData.first.fullName, 
                                email: BlocProvider.of<AuthBloc>(context).state.userData.first.email, 
                                uploaderProfilePictureImageUrl: BlocProvider.of<AuthBloc>(context).state.userData.first.profileImageUrl,
                                context: context,
                              )
                            );
                            captionController.text = "";
                            mainLoading(context);
                          }
                        },
                        child: Container(
                          width: width * 1,
                          decoration: BoxDecoration(
                            color: AppColor.uploadPageSecondaryColor,
                            borderRadius: BorderRadius.circular(screenFactor * 10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: height * 0.015),
                            child: Center(
                              child: Text("Upload",
                                style: TextStyle(
                                  fontSize: screenFactor * 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}