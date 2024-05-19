import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/features/auth/presentation/pages/sign_in.dart';
import 'package:wemet/features/auth/presentation/pages/sign_up.dart';
import 'package:wemet/features/user_profile/presentation/pages/user_profile.dart';
import 'package:wemet/mainpage.dart';
import 'package:wemet/splash_screen.dart';

class AppRoutes{
  static final GoRouter router = GoRouter(
    routes:[
      GoRoute(
        path: '/',
        name: AppRoutesConstant.splashScreen,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/signUp',
        name: AppRoutesConstant.signUp,
        builder: (context, state) {
          return const SignUp();
        },
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoutesConstant.signIn,
        builder: (context, state) {
          return const SignIn();
        },
      ),
      GoRoute(
        path: '/mainpage',
        name: AppRoutesConstant.mainPage,
        builder: (context, state) {
          return const MainPage();
        },
      ),
      GoRoute(
        path: '/userProfile',
        name: AppRoutesConstant.userprofile,
        builder: (context, state) => const UserProfile(),
      ),
    ],
  );
}