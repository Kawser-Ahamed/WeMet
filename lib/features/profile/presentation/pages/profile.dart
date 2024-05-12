import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = (width/Screen.designWidth);
    AuthState state =BlocProvider.of<AuthBloc>(context).state;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(state.userData.first.coverPhotoUrl,fit: BoxFit.fitWidth),
          ),
          Positioned(
            top: height * 0.3,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: height * 0.2,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: (width >600) ? height * 0 : height * 0.025),
                  Container(
                    height: (width >600) ? height * 0.2 : height * 0.15,
                    width: (width >600) ? height * 0.2 : height * 0.15,
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: (width >600) ? height * 0.1 :height * 0.075,
                      backgroundImage: NetworkImage(state.userData.first.profileImageUrl),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.32,
            bottom: 0,
            left: width * 0.05,
            right: width * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(state.userData.first.following.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                      ),
                    ),
                    Text("Followers",
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(state.userData.first.followers.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                      ),
                    ),
                    Text("Following",
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenFactor * 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            )
          ),
          Positioned(
            top: height * 0.4,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(state.userData.first.fullName,
                  style: TextStyle(
                    fontSize: screenFactor * 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(state.userData.first.bio,
                  style: TextStyle(
                    fontSize: screenFactor * 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}