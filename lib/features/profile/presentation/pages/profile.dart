import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_state.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final IconData globe = const IconData(0xf68d);

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    AuthState state = BlocProvider.of<AuthBloc>(context,listen: false).state;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(state.userData.first.coverPhotoUrl,fit: BoxFit.fitWidth),
          ),
          Positioned(
            top: height * 0.3,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: height * 0.2,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: (width >600) ? height * 0 : height * 0.025),
                  Container(
                    height: (width >600) ? height * 0.2 : height * 0.15,
                    width: (width >600) ? height * 0.2 : height * 0.15,
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: (width >600) ? height * 0.1 :height * 0.075,
                      backgroundImage: NetworkImage(state.userData.first.profileImageUrl),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.32,
            bottom: 0,
            left: width * 0.05,
            right: width * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(state.userData.first.following.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                      ),
                    ),
                    Text("Followers",
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(state.userData.first.followers.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                      ),
                    ),
                    Text("Following",
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            )
          ),
          Positioned(
            top: height * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Text(state.userData.first.fullName,
                  style: TextStyle(
                    fontSize: screenFactor * 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(state.userData.first.bio,
                  style: TextStyle(
                    fontSize: screenFactor * 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: BlocBuilder<ProfileBloc,ProfileState>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: state.profileData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Theme.of(context).colorScheme.background,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: height * 0.03,
                                          backgroundImage: NetworkImage(state.profileData[index].uploaderProfilePictureImageUrl),
                                        ),
                                        SizedBox(width: width * 0.05),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(state.profileData[index].uploaderName,
                                                style: GoogleFonts.aBeeZee(
                                                  fontSize: screenFactor * 30,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(state.profileData[index].dateTime,
                                                    style: TextStyle(
                                                      fontSize: screenFactor * 30,
                                                      fontWeight: FontWeight.normal
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.03),
                                                  Icon(CupertinoIcons.globe,size: screenFactor * 40,),
                                                ],
                                              )
                                            ],
                                          )
                                        ),
                                      ],
                                    ),
                                    (state.profileData[index].caption.isNotEmpty) 
                                    ? ExpandableText(
                                      state.profileData[index].caption,
                                      maxLines: 3,
                                      expandText: "Read more",
                                      collapseText: "Read less",
                                      style: TextStyle(
                                        fontSize: screenFactor * 30,
                                      ),
                                    ) : const SizedBox(),
                                    (state.profileData[index].imageUrl.isNotEmpty) 
                                    ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: height * 0.02),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(screenFactor * 30),
                                          child: Image.network(state.profileData[index].imageUrl)
                                        )
                                      ],
                                    ): const SizedBox(),
                                    SizedBox(height: height * 0.02),
                                    Icon(Icons.comment,size: screenFactor * 40),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}