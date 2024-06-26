import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/home/presentation/pages/homepage.dart';
import 'package:wemet/features/menu/presentation/pages/menu_page.dart';
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
    const Profile(),
    const MenuPage(),
  ];

  int bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    List<Widget> navBarItem = [
      Icon(Icons.home,size: width * 0.08,color: (bottomNavBarIndex==0) ? Colors.red:null),
      Icon(Icons.search,size: width * 0.08,color: (bottomNavBarIndex==1) ?  Colors.red:null),
      Icon(CupertinoIcons.add_circled,size: width * 0.09,color: (bottomNavBarIndex==2) ?  Colors.red:null),
      CircleAvatar(
        radius: width * 0.045,
        backgroundImage: NetworkImage(BlocProvider.of<AuthBloc>(context).state.userData.first.profileImageUrl),
      ),
      Icon(Icons.menu,size: width * 0.08,color: (bottomNavBarIndex==4) ?  Colors.red:null),
    ];
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.background,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
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
      ),
    );
  }
}