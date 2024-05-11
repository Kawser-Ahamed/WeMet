import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/home/presentation/pages/homepage.dart';
import 'package:wemet/features/notification/presentation/pages/notification_page.dart';
import 'package:wemet/features/profile/presentation/pages/profile.dart';
import 'package:wemet/features/search/presentation/pages/search.dart';
import 'package:wemet/features/upload/presentation/pages/upload_post.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Widget> pages = [
    const HomePage(),
    const Search(),
    const UploadPost(),
    const NotificationPage(),
    const Profile(),
  ];

  int bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    List<Widget> navBarItem = [
      Icon(Icons.home,size: width * 0.08,color: (bottomNavBarIndex==0) ? Colors.red:Colors.black),
      Icon(Icons.search,size: width * 0.08,color: (bottomNavBarIndex==1) ?  Colors.red:Colors.black),
      Icon(CupertinoIcons.add_circled,size: width * 0.09,color: (bottomNavBarIndex==2) ?  Colors.red:Colors.black),
      Icon(Icons.notifications,size: width * 0.08,color: (bottomNavBarIndex==3) ?  Colors.red:Colors.black),
      Container(
        height: width * 0.1,
        width: width * 0.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          image: DecorationImage(
            image: NetworkImage(BlocProvider.of<AuthBloc>(context).state.userData.first.profileImageUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: Card(
        elevation: 0,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade500),
            )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: height * 0.02),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5, 
                  (index) => InkWell(
                    onTap: (){
                      setState(() {
                        bottomNavBarIndex = index;
                      });
                    },
                    child: navBarItem[index]
                  ),
                ),
              ),
          ),
        ),
      ),
      body: pages[bottomNavBarIndex],
    );
  }
}