import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/following/presentation/pages/following.dart';
import 'package:wemet/features/home/presentation/widget/post_category.dart';
import 'package:wemet/features/home/presentation/widget/posts.dart';
import 'package:wemet/features/home/presentation/widget/wemet_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController = ScrollController();
  double screenPosition = 0.0;

  void _onScroll(){
    setState(() {
      screenPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const WemetAppBar(),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height:  (screenPosition >= 50) ? 0 : height * 0.12,
            width: width * 1,
            margin: EdgeInsets.symmetric(vertical: height * 0.01),
            child: const Following(),
          ),
          const PostCategory(),
          Expanded(child: Posts(scrollController: _scrollController)),
        ],
      ),
    );
  }
}