import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/config/routes/app_routes.dart';
import 'package:wemet/config/theme/bloc/theme_bloc.dart';
import 'package:wemet/config/theme/theme.dart';
import 'package:wemet/core/dependency/init_dependency.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/post_category/post_category_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_bloc.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wemet/features/search/presentation/bloc/search_bloc.dart';
import 'package:wemet/features/upload/presentation/bloc/upload_post_bloc.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:wemet/firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependency();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const WeMet());
}

class WeMet extends StatelessWidget {
  const WeMet({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ThemeBloc()),
        BlocProvider(create: (context)=> serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<PostCategoryBloc>()),
        BlocProvider(create: (context) => serviceLocator<UploadPostBloc>()),
        BlocProvider(create: (context) => serviceLocator<PostsBloc>()),
        BlocProvider(create: (context) => serviceLocator<ProfileBloc>()),
        BlocProvider(create: (context) => serviceLocator<CommentBloc>()),
        BlocProvider(create: (context) => serviceLocator<UserProfileBloc>()),
        BlocProvider(create: (context) => serviceLocator<EditProfileBloc>()),
        BlocProvider(create: (context) => serviceLocator<SearchBloc>()),
      ],
      child: BlocBuilder<ThemeBloc,ThemeMode>(
        builder: (context, themeState) {
          return MaterialApp.router(
            routerConfig: AppRoutes.router,
            theme: lightTheme,
            themeMode: themeState,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}