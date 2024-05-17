import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_event.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_state.dart';
import 'package:wemet/features/home/presentation/widget/followers.dart';
import 'package:wemet/features/home/presentation/widget/post_category.dart';
import 'package:wemet/features/home/presentation/widget/wemet_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<PostsBloc>().add(AllPostsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const WemetAppBar(),
          const Followers(),
          const PostCategory(),
          BlocBuilder<PostsBloc,AllPostsState>(
            builder: (context, state) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.allPostData.length,
                itemBuilder: (context, index) {
                  return Text(state.allPostData[index].caption);
                },
              );
            },
          ),
          //ShimmerLoading(),
        ],
      ),
    );
  }
}