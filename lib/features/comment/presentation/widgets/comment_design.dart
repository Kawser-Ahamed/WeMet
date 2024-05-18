import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_event.dart';
import 'package:wemet/features/comment/presentation/widgets/comment.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_bloc.dart';

class CommentDesign extends StatefulWidget {
  final int index;
  const CommentDesign({super.key, required this.index});

  @override
  State<CommentDesign> createState() => _CommentDesignState();
}

class _CommentDesignState extends State<CommentDesign> {

  TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            context.read<CommentBloc>().add(FetchCommentEvent(id: BlocProvider.of<PostsBloc>(context).state.postData[widget.index].id));
            comments(context,BlocProvider.of<PostsBloc>(context).state.postData[widget.index].uploaderName);
          },
          child: Icon(Icons.comment,size: screenFactor * 50),
        ),
        SizedBox(width: width * 0.03),
        Expanded(
          flex: 2,
          child: Material(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(screenFactor * 50),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.comment_bank_outlined,size: screenFactor * 30),
                  hintText: 'Comment as ${BlocProvider.of<AuthBloc>(context).state.userData.first.fullName}',
                  hintStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: screenFactor * 20,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.02),
        Expanded(
          child: InkWell(
            onTap: (){
              if(commentController.text.isNotEmpty){
                var data =BlocProvider.of<AuthBloc>(context).state.userData[widget.index];
                DateFormat dateFormat =  DateFormat("dd-MM-yyyy HH:mm");
                String currentTime = dateFormat.format(DateTime.now());
                context.read<CommentBloc>().add(
                  UploadCommentEvent(
                    id: BlocProvider.of<PostsBloc>(context).state.postData[widget.index].id, 
                    comment: commentController.text, 
                    dateTime: currentTime, 
                    commenterName: data.fullName, 
                    email: data.email, 
                    commenterProfilePictureImageUrl: data.profileImageUrl, 
                    context: context
                  ),
                );
                commentController.text = '';
              }
            },
            child: Material(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(screenFactor * 50),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Text("Comment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: screenFactor * 30,
                  color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ),
      ],
    );
  }
}