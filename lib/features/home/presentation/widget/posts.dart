import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/comment/presentation/widgets/comment_design.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_event.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_state.dart';
import 'package:wemet/features/home/presentation/widget/shimmer.dart';

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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      
                                    },
                                    child: Text(state.postData[index].uploaderName,
                                      maxLines: 1,
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: screenFactor * 30,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(state.postData[index].dateTime,
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(screenFactor * 30),
                              child: Image.network(state.postData[index].imageUrl)
                            )
                          ],
                        ): const SizedBox(),
                        SizedBox(height: height * 0.02),
                        CommentDesign(index: index),
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