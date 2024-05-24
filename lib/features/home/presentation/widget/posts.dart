import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/comment/presentation/widgets/comment_design.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_event.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_state.dart';
import 'package:wemet/features/home/presentation/widget/report.dart';
import 'package:wemet/features/home/presentation/widget/shimmer.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  @override
  void initState() {
    context.read<PostsBloc>().add(AllPostsEvent(url: '${Serverurls.postUrl}/all'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: BlocBuilder<PostsBloc,AllPostsState>(
        builder: (context, state) {
          if(state.uiStatus == UiStatus.loading){
            return const ShimmerLoading();
          }
          else if(state.uiStatus == UiStatus.error){
            return Text(state.message);
          }
          else{
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.postData.length,
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
                              backgroundImage: NetworkImage(state.postData[index].uploaderProfilePictureImageUrl),
                            ),
                            SizedBox(width: width * 0.05),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      context.read<UserProfileBloc>().add(UserProfileDataEvent(email: state.postData[index].email,isView: true,context: context));
                                      mainLoading(context);
                                    },
                                    child: Text(state.postData[index].uploaderName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: screenFactor * 30,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(state.postData[index].dateTime,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: screenFactor * 30,
                                            fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width * 0.03),
                                      Icon(CupertinoIcons.globe,size: screenFactor * 40,),
                                    ],
                                  )
                                ],
                              )
                            ),
                            Expanded(
                              child: PopupMenuButton(
                                elevation: 0,
                                color: Theme.of(context).colorScheme.background,
                                icon: Icon(Icons.more_vert,size: screenFactor * 40,),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Report",
                                          style: TextStyle(
                                            fontSize: screenFactor * 25,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        InkWell(
                                          onTap:(){
                                            reportDialogue(context);
                                          },
                                          child: Text("Fake post",
                                            style: TextStyle(
                                              fontSize: screenFactor * 25,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            reportDialogue(context);
                                          },
                                          child: Text("Violence",
                                            style: TextStyle(
                                              fontSize: screenFactor * 25,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            reportDialogue(context);
                                          },
                                          child: Text("False Information",
                                            style: TextStyle(
                                              fontSize: screenFactor * 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ]
                              ),
                            ),
                          ],
                        ),
                        (state.postData[index].caption.isNotEmpty) 
                        ? ExpandableText(
                          state.postData[index].caption,
                          maxLines: 3,
                            expandText: "Read more",
                            collapseText: "Read less",
                            style: TextStyle(
                            fontSize: screenFactor * 30,
                            ),
                        ) : const SizedBox(),
                        (state.postData[index].imageUrl.isNotEmpty) 
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.02),
                            InkWell(
                              onTap: (){
                                GoRouter.of(context).pushNamed(
                                  AppRoutesConstant.postViewPage,pathParameters: {
                                    'imageUrl' : state.postData[index].imageUrl,
                                    'name' : state.postData[index].uploaderName,
                                    'profileImage' : state.postData[index].uploaderProfilePictureImageUrl,
                                    'dateTime' : state.postData[index].dateTime,
                                    'caption' : state.postData[index].caption,
                                  }
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(screenFactor * 20),
                                child: Image.network(state.postData[index].imageUrl)
                              ),
                            )
                          ],
                        ): const SizedBox(),
                        SizedBox(height: height * 0.02),
                        CommentDesign(index: index,postList: state.postData),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}