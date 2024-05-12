import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    AuthState state = BlocProvider.of<AuthBloc>(context).state;
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width * 0.03,),
          CircleAvatar(
            radius: height * 0.05,
            backgroundImage: NetworkImage(state.userData.first.profileImageUrl),
          ),
          Expanded(
            child:  SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  growable: true,
                  10, (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: CircleAvatar(
                      radius: height * 0.05,
                      backgroundImage: AssetImage(AppImageUrls.avatar),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}