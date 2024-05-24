import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';
import 'package:wemet/features/comment/presentation/widgets/comment_design.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_state.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          BlocBuilder<AuthBloc,AuthState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: height * 0.5,
                    right: 0,
                    child: InkWell(
                      onTap: (){
                        GoRouter.of(context).pushNamed(
                          AppRoutesConstant.postViewPage,pathParameters: {
                            'imageUrl' : state.userData.first.coverPhotoUrl,
                            'name' : state.userData.first.fullName,
                            'profileImage' : state.userData.first.profileImageUrl,
                            'dateTime' : " ",
                            'caption' : " ",
                          }
                        );
                      },
                      child: Material(
                        color: Theme.of(context).colorScheme.onPrimary,
                        child: Image.network(state.userData.first.coverPhotoUrl,fit: BoxFit.cover)),
                    ),
                  ),
                  Positioned(
                    top: height * 0.3,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
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
                            child: InkWell(
                              onTap: (){
                               GoRouter.of(context).pushNamed(
                                  AppRoutesConstant.postViewPage,pathParameters: {
                                    'imageUrl' : state.userData.first.profileImageUrl,
                                    'name' : state.userData.first.fullName,
                                    'profileImage' : state.userData.first.profileImageUrl,
                                    'dateTime' : " ",
                                    'caption' : " ",
                                  }
                                );
                              },
                              child: CircleAvatar(
                                radius: (width >600) ? height * 0.1 :height * 0.075,
                                backgroundImage: NetworkImage(state.userData.first.profileImageUrl),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: (){
                                      GoRouter.of(context).pushNamed(AppRoutesConstant.editPicture,
                                        pathParameters: {
                                          'pictureType' : "Profile Picture",
                                          'imageUrl' : state.userData.first.profileImageUrl,
                                        }
                                      );
                                    },
                                    child: Container(
                                      height: (width >600) ? height * 0.07 : height * 0.06,
                                      width: (width >600) ? height * 0.07 : height * 0.06,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: FittedBox(
                                        child: Padding(
                                          padding: EdgeInsets.all(screenFactor * 10),
                                          child: const Icon(Icons.camera_alt,color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.2,
                    right: width * 0.03,
                    height: height * 0.08,
                    width: height * 0.08,
                    child: GestureDetector(
                      onTap: (){
                        GoRouter.of(context).pushNamed(AppRoutesConstant.editPicture,
                          pathParameters: {
                            'pictureType' : "Cover Photo",
                            'imageUrl' : state.userData.first.coverPhotoUrl,
                          }
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                        ),
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(screenFactor * 15),
                            child: const Icon(Icons.camera_alt,color: Colors.black),
                          ),
                        ),
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
                            Text(state.userData.first.followers.toString(),
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
                            Text(state.userData.first.following.toString(),
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
                ],
              );
            },
          ),
          Positioned(
            top: height * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AuthBloc,AuthState>(
                    builder: (context, authState) {
                      return Column(
                        children: [
                          Center(
                            child: Text(authState.userData.first.fullName,
                              style: TextStyle(
                                fontSize: screenFactor * 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(authState.userData.first.bio,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenFactor * 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          InkWell(
                            onTap: (){
                              GoRouter.of(context).pushNamed(
                                AppRoutesConstant.editProfile,
                                pathParameters: {
                                  'fullName' : authState.userData.first.fullName,
                                  'bio' : authState.userData.first.bio,
                                  'email': authState.userData.first.email
                                }
                              );
                              //showEditDialog(context,name,bio,authState.userData.first.email);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(screenFactor * 50),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit,size: screenFactor * 50),
                                    SizedBox(width: width * 0.05),
                                    Text("Edit profile",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: screenFactor * 30,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: BlocBuilder<ProfileBloc,ProfileState>(
                        builder: (context, state) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.profileData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: height * 0.01,left: width * 0.02,right: width * 0.02),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      color: Colors.grey.shade500,
                                    )
                                  ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: height * 0.02),
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
                                                  maxLines: 1,
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
                                          InkWell(
                                            onTap: (){
                                               GoRouter.of(context).pushNamed(
                                                AppRoutesConstant.postViewPage,pathParameters: {
                                                  'imageUrl' : state.profileData[index].imageUrl,
                                                  'name' : state.profileData[index].uploaderName,
                                                  'profileImage' : state.profileData[index].uploaderProfilePictureImageUrl,
                                                  'dateTime' : state.profileData[index].dateTime,
                                                  'caption' : state.profileData[index].caption,
                                                }
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(screenFactor * 20),
                                              child: Image.network(state.profileData[index].imageUrl)
                                            ),
                                          )
                                        ],
                                      ): const SizedBox(),
                                      SizedBox(height: height * 0.02),
                                      CommentDesign(index: index,postList: state.profileData),
                                      SizedBox(height: height * 0.02),
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
              ),
            )
          ),
        ],
      ),
    );
  }
}