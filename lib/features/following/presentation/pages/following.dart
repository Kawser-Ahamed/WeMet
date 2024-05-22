import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/urls/app_image_urls.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenfactor = (width/Screen.designWidth);
    AuthState state = BlocProvider.of<AuthBloc>(context,listen: false).state;
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: width * 0.03),
            Container(
              width: height * 0.08,
              color: Colors.transparent,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: height * 0.04,
                    backgroundImage: NetworkImage(state.userData.first.profileImageUrl),
                  ),
                  Text('You',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee(
                      fontSize: screenfactor * 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    growable: true,
                    10, (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0),
                      child: Container(
                        width: height * 0.12,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: height * 0.04,
                              backgroundImage: AssetImage(AppImageUrls.avatar),
                            ),
                            Text('Followers',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                fontSize: screenfactor * 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}