import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/main_loading.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/core/urls/app_image_urls.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/search/presentation/bloc/search_bloc.dart';
import 'package:wemet/features/search/presentation/bloc/search_event.dart';
import 'package:wemet/features/search/presentation/bloc/search_state.dart';
import 'package:wemet/features/search/presentation/widget/search_text_field.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_event.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<SearchBloc>().add(RandomUserEvent());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double screenFactor = width/Screen.designWidth;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade500),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    color: Colors.transparent,
                    child: FittedBox(
                      child: Image.asset(AppImageUrls.appIcon),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(screenFactor * 50),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: SearchTextField(controller: searchController),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  InkWell(
                    onTap: (){
                      if(searchController.text.isNotEmpty){
                        context.read<SearchBloc>().add(SearchUserEvent(searchValue: searchController.text.toLowerCase(), context: context));
                        mainLoading(context);
                      }
                    },
                    child: Icon(Icons.search,size: screenFactor * 60)
                  ),
                  SizedBox(width: width * 0.03),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Column(
                  children: [
                    BlocBuilder<SearchBloc,SearchState>(
                      builder: (context, state) {
                        if(state.uiStatus == UiStatus.success && state.randomUser.isNotEmpty){
                          return (state.randomUser.first.email != BlocProvider.of<AuthBloc>(context).state.userData.first.email) ? Container(
                            width: width * 1,
                            constraints: BoxConstraints(maxWidth: width),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.02),
                                Text("Suggested For you",
                                  style: TextStyle(
                                    fontSize: screenFactor * 40,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Card(
                                  elevation: 0,
                                  color: Theme.of(context).colorScheme.background,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: height * 0.01),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.background,
                                      borderRadius: BorderRadius.circular(screenFactor * 10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                        ),
                                      ]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.02),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              context.read<UserProfileBloc>().add(UserProfileDataEvent(email: state.randomUser.first.email,isView: true,context: context));
                                              mainLoading(context);
                                            },
                                            child: Container(
                                              height: height * 0.2,
                                              width: width * 0.5,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade500,
                                                borderRadius: BorderRadius.circular(screenFactor * 10),
                                                image: DecorationImage(
                                                  image: NetworkImage(state.randomUser.first.profileImageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: height * 0.005),
                                          InkWell(
                                            onTap: (){
                                              context.read<UserProfileBloc>().add(UserProfileDataEvent(email: state.randomUser.first.email,isView: true,context: context));
                                              mainLoading(context);
                                            },
                                            child: Text(state.randomUser.first.fullName,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: screenFactor * 35,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                                SizedBox(height: height * 0.005),
                              ],
                            ),
                          ) : const SizedBox();
                        }
                        else{
                          return const SizedBox();
                        }
                      },
                    ),
                    BlocBuilder<SearchBloc,SearchState>(
                      builder: (context, state) {
                        if(state.searchUistatus == UiStatus.success && state.searchUser.isNotEmpty){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("People",
                                style: TextStyle(
                                  fontSize: screenFactor * 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.searchUser.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0,
                                    color: Theme.of(context).colorScheme.background,
                                    child: InkWell(
                                      onTap: (){
                                        context.read<UserProfileBloc>().add(UserProfileDataEvent(email: state.searchUser[index].email,isView: true,context: context));
                                        mainLoading(context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: height * 0.01),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.background,
                                          borderRadius: BorderRadius.circular(screenFactor * 10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                            ),
                                          ]
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.02),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: height * 0.03,
                                                backgroundImage: NetworkImage(state.searchUser[index].profileImageUrl),
                                              ),
                                              SizedBox(width: width * 0.03),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(state.searchUser[index].fullName,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.aBeeZee(
                                                        fontSize: screenFactor * 30,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(state.searchUser[index].bio,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: screenFactor * 30,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }
                        else{
                          return const SizedBox();
                        } 
                      },
                    ),
                  ],
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}