import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/comment/presentation/widgets/comment_design.dart';
import 'package:wemet/features/following/presentation/bloc/following_bloc.dart';
import 'package:wemet/features/following/presentation/bloc/following_event.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_state.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        height: height * 1,
        width: width * 1,
        color: Theme.of(context).colorScheme.background,
        child: BlocBuilder<UserProfileBloc,UserProfileState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text("${state.userprofileData.first.fullName}'s Profile",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                            fontSize: screenFactor * 30,
                            fontWeight: FontWeight.normal,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width * 1,
                          color: Theme.of(context).colorScheme.background,
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: (){
                                  GoRouter.of(context).pushNamed(
                                    AppRoutesConstant.postViewPage,pathParameters: {
                                      'imageUrl' : state.userprofileData.first.coverPhotoUrl,
                                      'name' : state.userprofileData.first.fullName,
                                      'profileImage' : state.userprofileData.first.profileImageUrl,
                                      'dateTime' : " ",
                                      'caption' : " ",
                                    }
                                  );
                                },
                                child: Container(
                                  width: width,
                                  color: Theme.of(context).colorScheme.background,
                                  child: Image.network(state.userprofileData.first.coverPhotoUrl,fit: BoxFit.fitWidth),
                                ),
                              ),
                              Positioned(
                                bottom: height * 0.01,
                                left: width * 0.03,
                                child: InkWell(
                                  onTap: (){
                                    GoRouter.of(context).pushNamed(
                                      AppRoutesConstant.postViewPage,pathParameters: {
                                        'imageUrl' : state.userprofileData.first.profileImageUrl,
                                        'name' : state.userprofileData.first.fullName,
                                        'profileImage' : state.userprofileData.first.profileImageUrl,
                                        'dateTime' : " ",
                                        'caption' : " ",
                                      }
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: height * 0.06,
                                    backgroundImage: NetworkImage(state.userprofileData.first.profileImageUrl),
                                  ),
                                ),
                              ), 
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.02),
                              Text(state.userprofileData.first.fullName,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: screenFactor * 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(state.userprofileData.first.bio,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: screenFactor * 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Row(
                                children: [
                                  Icon(Icons.people_alt_outlined,size: screenFactor * 40),
                                  SizedBox(width: width * 0.03),
                                  Text("Followers: ",
                                    style: GoogleFonts.arima(
                                      fontSize: screenFactor * 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(state.userprofileData.first.followers.toString(),
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: screenFactor * 30,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.people_sharp,size: screenFactor * 40),
                                  SizedBox(width: width * 0.03),
                                  Text("Following: ",
                                    style: GoogleFonts.arima(
                                      fontSize: screenFactor * 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(state.userprofileData.first.following.toString(),
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: screenFactor * 30,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              (BlocProvider.of<AuthBloc>(context).state.userData.first.id != BlocProvider.of<UserProfileBloc>(context).state.userprofileData.first.id) ?
                              InkWell(
                                onTap: (){
                                  if(BlocProvider.of<FollowingBloc>(context).state.followingUserMap.containsKey(state.userprofileData.first.id)){
                                    context.read<FollowingBloc>().add(
                                      RemoveFollowingEvent(
                                        userEmail:  BlocProvider.of<AuthBloc>(context).state.userData.first.email, 
                                        followingEmail: state.userprofileData.first.email, 
                                        fullName: state.userprofileData.first.fullName,
                                        context: context,
                                      )
                                    );
                                    mainLoading(context);
                                  }
                                  else{
                                    context.read<FollowingBloc>().add(
                                      AddFollowingEvent(
                                        userEmail: BlocProvider.of<AuthBloc>(context).state.userData.first.email, 
                                        followingEmail: state.userprofileData.first.email, 
                                        fullName: state.userprofileData.first.fullName,
                                        context: context
                                      ),
                                    );
                                    mainLoading(context);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(screenFactor * 50),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: width * 0.1,vertical: height * 0.01),
                                    child: (BlocProvider.of<FollowingBloc>(context).state.followingUserMap.containsKey(state.userprofileData.first.id)) ? Text("Following",
                                      style: TextStyle(
                                        fontSize: screenFactor * 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ) : Text("Follow",
                                      style: TextStyle(
                                        fontSize: screenFactor * 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ) : const SizedBox(),
                              SizedBox(height: height * 0.02),
                              Row(
                                children: [
                                  Icon(Icons.image,color: Colors.green,size: screenFactor * 50),
                                  SizedBox(width: width * 0.03),
                                  Text("Posts",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: screenFactor * 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.userProfilePost.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: height * 0.01),
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
                                                backgroundImage: NetworkImage(state.userProfilePost[index].uploaderProfilePictureImageUrl),
                                              ),
                                              SizedBox(width: width * 0.05),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(state.userProfilePost[index].uploaderName,
                                                      maxLines: 1,
                                                      style: GoogleFonts.aBeeZee(
                                                        fontSize: screenFactor * 30,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(state.userProfilePost[index].dateTime,
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
                                          (state.userProfilePost[index].caption.isNotEmpty) 
                                          ? ExpandableText(
                                            state.userProfilePost[index].caption,
                                            maxLines: 3,
                                              expandText: "Read more",
                                              collapseText: "Read less",
                                              style: TextStyle(
                                              fontSize: screenFactor * 30,
                                              ),
                                          ) : const SizedBox(),
                                          (state.userProfilePost[index].imageUrl.isNotEmpty) 
                                          ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: height * 0.02),
                                              InkWell(
                                                onTap: (){
                                                  GoRouter.of(context).pushNamed(
                                                    AppRoutesConstant.postViewPage,pathParameters: {
                                                      'imageUrl' : state.userProfilePost[index].imageUrl,
                                                      'name' : state.userprofileData.first.fullName,
                                                      'profileImage' : state.userprofileData.first.profileImageUrl,
                                                      'dateTime' : state.userProfilePost[index].dateTime,
                                                      'caption' : state.userProfilePost[index].caption,
                                                    }
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(screenFactor * 20),
                                                  child: Image.network(state.userProfilePost[index].imageUrl)
                                                ),
                                              )
                                            ],
                                          ): const SizedBox(),
                                          SizedBox(height: height * 0.02),
                                          CommentDesign(index: index,postList: state.userProfilePost),
                                          SizedBox(height: height * 0.02),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}