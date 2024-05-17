import 'package:flutter/material.dart';
import 'package:wemet/features/home/presentation/widget/followers.dart';
import 'package:wemet/features/home/presentation/widget/post_category.dart';
import 'package:wemet/features/home/presentation/widget/posts.dart';
import 'package:wemet/features/home/presentation/widget/wemet_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
           const WemetAppBar(),
           const Followers(),
           const PostCategory(),
           Divider(color: Colors.grey.shade500),
           const Expanded(child: Posts()),
        ],
      ),
    );
  }
}