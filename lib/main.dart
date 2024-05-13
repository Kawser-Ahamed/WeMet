import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/config/routes/app_routes.dart';
import 'package:wemet/config/theme/bloc/theme_bloc.dart';
import 'package:wemet/config/theme/theme.dart';
import 'package:wemet/features/auth/data/datasource/auth_datasource.dart';
import 'package:wemet/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:wemet/features/auth/domain/usecase/signin_usecase.dart';
import 'package:wemet/features/auth/domain/usecase/signup_usecase.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/home/data/datasource/post_category_datasource.dart';
import 'package:wemet/features/home/data/repositories/post_category_repository_implementation.dart';
import 'package:wemet/features/home/domain/usecase/post_category_usecase.dart';
import 'package:wemet/features/home/presentation/bloc/post_category_bloc.dart';
import 'package:wemet/firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const WeMet());
}

class WeMet extends StatelessWidget {
  const WeMet({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>
          AuthBloc(
            signupUseCase: SignUpUseCase(
              AuthRepositoryImplementation(
                AuthDatasourceImplementation(),
              ),
            ),
            singInUseCase: SignInUseCase(
              AuthRepositoryImplementation(
                AuthDatasourceImplementation(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context)=> ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => PostCategoryBloc(
            postCategoryUseCase: PostCategoryUseCase(
              PostCategoryRepositoryImplementation(
                PostCategoryDatasourceImplementation(),
              ),
            ),
          ),
        ),
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