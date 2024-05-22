
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_state.dart';
import 'package:wemet/features/comment/presentation/widgets/comment_loading.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';

Future<void> comments(BuildContext context,String uploaderName){
  double height = Screen.screenHeight(context);
  double width = Screen.screenWidth(context);
  double screenFactor = width/Screen.designWidth;
  return showModalBottomSheet(
    context: context, 
    builder: (context) {
      return Container(
        height: height * 0.7,
        width: width * 1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenFactor * 30),
            topRight: Radius.circular(screenFactor * 30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.01),
            Text("$uploaderName's Post",
              maxLines: 1,
              style: GoogleFonts.aBeeZee(
                fontSize: screenFactor * 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.01),
            Divider(color: Colors.grey.shade500),
            Expanded(
              child: BlocBuilder<CommentBloc,CommentState>(
                builder: (context, state) {
                  if(state.uiStatus == UiStatus.loading){
                    return const CommentLoading();
                  }
                  else if(state.uiStatus == UiStatus.error){
                    return Text(state.message);
                  }
                  else if(state.commentData.isEmpty){
                    return Center(
                      child: Text("No Comment Yet",
                        style: TextStyle(
                          fontSize: screenFactor * 40,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    );
                  }
                  else{
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.03),
                          child: Row(
                            children: [
                              Text("Total comments: ",
                                style: TextStyle(
                                  fontSize: screenFactor * 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(state.commentData.length.toString(),
                                style: TextStyle(
                                  fontSize: screenFactor * 35,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.commentData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                color: Theme.of(context).colorScheme.background,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    borderRadius: BorderRadius.circular(screenFactor * 20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      )
                                    ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: height * 0.03,
                                              backgroundImage: NetworkImage(state.commentData[index].commenterProfilePictureImageUrl),
                                            ),
                                            SizedBox(width: width * 0.05),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    context.read<UserProfileBloc>().add(UserProfileDataEvent(email: state.commentData[index].email,isView: true,context: context));
                                                    mainLoading(context);
                                                  },
                                                  child: Text(state.commentData[index].commenterName,
                                                    style: GoogleFonts.aBeeZee(
                                                      fontSize: screenFactor * 30,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(state.commentData[index].dateTime,
                                                  style: TextStyle(
                                                    fontSize: screenFactor * 30,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.01),
                                        Text(state.commentData[index].comment,
                                          style: TextStyle(
                                            fontSize: screenFactor * 30,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}