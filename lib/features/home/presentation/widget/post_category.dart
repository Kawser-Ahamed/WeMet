import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/home/presentation/bloc/post_category_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/post_category_event.dart';
import 'package:wemet/features/home/presentation/bloc/post_category_state.dart';
import 'package:wemet/features/home/presentation/widget/category_loading.dart';

class PostCategory extends StatefulWidget {
  const PostCategory({super.key});

  @override
  State<PostCategory> createState() => _PostCategoryState();
}

class _PostCategoryState extends State<PostCategory> {

  @override
  void initState() {
    context.read<PostCategoryBloc>().add(const PostCategoryEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.background,
      child: BlocBuilder<PostCategoryBloc,PostCategoryState>(
        builder: (context, state) {
          if(state.uiStatus == UiStatus.loading){
            return const CategoryLoading();
          }
          else if(state.uiStatus == UiStatus.error){
            return Text(state.errorMessage);
          }
          else{
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.03),
                child: Container(
                  width: width * 1,
                  color: Theme.of(context).colorScheme.background,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      state.postCategoryData.length, (index) => Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.onPrimary,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.01,horizontal: width * 0.05),
                          child: Text(state.postCategoryData[index].name,
                            style: GoogleFonts.aBeeZee(
                              fontSize: screenFactor * 30,
                            ),
                          )
                        ),
                      )
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}