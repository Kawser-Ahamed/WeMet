import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/core/reusable/wemet_image_picker.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_event.dart';

class EditProfilePicture extends StatefulWidget {
  final String imageUrl;
  const EditProfilePicture({super.key, required this.imageUrl});

  @override
  State<EditProfilePicture> createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {

  WemetImagePicker wemetImagePicker = WemetImagePicker();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              Text("Edit Picture",
                style: GoogleFonts.aBeeZee(
                  fontSize: screenFactor * 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  border: Border.all(color: Colors.grey.shade500),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                wemetImagePicker.pickImageFromGallery().whenComplete((){
                                  setState(() {
                                    
                                  });
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  border: Border.all(color: Colors.grey.shade500),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.01),
                                  child: Icon(Icons.folder_copy,size: screenFactor * 60)
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            InkWell(
                              onTap: (){
                                wemetImagePicker.pickImageFromCamera().whenComplete((){
                                  setState(() {
                                    
                                  });
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  border: Border.all(color: Colors.grey.shade500),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.01),
                                  child: Icon(Icons.camera_alt,size: screenFactor * 60)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
                          child: (wemetImagePicker.imageFromDevice == null) ? 
                          Image.network(widget.imageUrl) : Image.file(wemetImagePicker.imageFromDevice!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              InkWell(
                onTap: (){
                  if(wemetImagePicker.imageFromDevice != null){
                    context.read<EditProfileBloc>().add(
                      EditProfilePictureEvent(
                        email: BlocProvider.of<AuthBloc>(context).state.userData.first.email,
                        context: context,
                        profilePicture: wemetImagePicker.imageFromDevice!
                      ),
                    );
                    mainLoading(context);
                  }
                },
                child: Container(
                  width: width * 1,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(screenFactor * 10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    child: Text("Update Profile Picture",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenFactor * 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}