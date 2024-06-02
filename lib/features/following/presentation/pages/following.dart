import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_state.dart';
import 'package:wemet/features/following/presentation/bloc/following_bloc.dart';
import 'package:wemet/features/following/presentation/bloc/following_event.dart';
import 'package:wemet/features/following/presentation/bloc/following_state.dart';
import 'package:wemet/features/following/presentation/widgets/following_loading.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';
class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {

  @override
  void initState() {
    context.read<FollowingBloc>().add(FetchFollowingEvent(email: BlocProvider.of<AuthBloc>(context).state.userData.first.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenfactor = (width/Screen.designWidth);
    AuthState state = BlocProvider.of<AuthBloc>(context,listen: false).state;
    return FittedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: width * 0.02),
          Column(
            children: [
              CircleAvatar(
                radius: height * 0.05,
                backgroundImage: NetworkImage(state.userData.first.profileImageUrl),
              ),
              Text('You',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.aBeeZee(
                  fontSize: screenfactor * 35,
                ),
              ),
            ],
          ),
          SizedBox(width: width * 0.02),
          SizedBox(
            width: width * 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: BlocBuilder<FollowingBloc,FollowingState>(
                builder: (context, state) {
                  if(state.uiStatus == UiStatus.loading){
                    return const FolowingLoading();
                  }
                  else if(state.uiStatus == UiStatus.error){
                    return Text(state.message);
                  }
                  else{
                    return Row(
                      children: List.generate(
                        growable: true,
                        state.followingUserMap.length, (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0),
                          child: Container(
                            width: height * 0.12,
                            color: Colors.transparent,
                            margin: EdgeInsets.only(right: width * 0.01),
                            child: InkWell(
                              onTap: (){
                                context.read<UserProfileBloc>().add(UserProfileDataEvent(email: state.followingUserMap.values.elementAt(index).email, isView: true, context: context));
                                mainLoading(context);
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: height * 0.05,
                                    backgroundImage: NetworkImage(state.followingUserMap.values.elementAt(index).profileImageUrl),
                                  ),
                                  Text(state.followingUserMap.values.elementAt(index).fullName,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: (width/Screen.designWidth) * 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ]
      ),
    );
  }
}