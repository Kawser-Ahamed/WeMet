import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:wemet/features/edit_profile/presentation/widgets/edit_text_field.dart';

class Editprofile extends StatefulWidget {
  final String fullName;
  final String bio;
  final String email;
  const Editprofile({super.key,required this.email, required this.fullName, required this.bio});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  
  TextEditingController fullNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    fullNameController.text = widget.fullName;
    bioController.text = widget.bio;
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  Text("Edit Profile",
                    style: GoogleFonts.aBeeZee(
                      fontSize: screenFactor * 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.search,size: screenFactor * 60),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.05),
                    Text("Edit Your Profile",
                      style: TextStyle(
                        fontSize: screenFactor * 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    EditTextField(controller: fullNameController,labelText: "Full Name"),
                    SizedBox(height: height * 0.02),
                    EditTextField(controller: bioController,labelText: "Bio"),
                    SizedBox(height: height * 0.02),
                    InkWell(
                      onTap: (){
                        context.read<EditProfileBloc>().add(EditProfileDataEvent(fullName: fullNameController.text, bio: bioController.text, email: widget.email, context: context));
                        mainLoading(context);
                      },
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(screenFactor * 10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.015),
                          child: Text("Update",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenFactor * 35,
                              color: Colors.white,
                            ),
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}