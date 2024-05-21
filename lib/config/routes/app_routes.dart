import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/features/auth/presentation/pages/sign_in.dart';
import 'package:wemet/features/auth/presentation/pages/sign_up.dart';
import 'package:wemet/features/edit_profile/presentation/pages/edit_picture.dart';
import 'package:wemet/features/edit_profile/presentation/pages/edit_profile.dart';
import 'package:wemet/features/home/presentation/widget/post_view_page.dart';
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
      GoRoute(
        path: '/editProfile/:fullName/:bio/:email',
        name: AppRoutesConstant.editProfile,
        builder: (context, state) => 
        Editprofile(
          fullName: state.pathParameters['fullName']!,
          bio: state.pathParameters['bio']!,
          email: state.pathParameters['email']!,
        ),
      ),
      GoRoute(
        path: '/editPicture/:pictureType/:imageUrl',
        name: AppRoutesConstant.editPicture,
        builder: (context, state) => 
        EditPicture(
          pictureType: state.pathParameters['pictureType']!, 
          imageUrl: state.pathParameters['imageUrl']!,
        ),
      ),
      GoRoute(
        path: '/postViewPage/:imageUrl/:name/:profileImage/:dateTime/:caption',
        name: AppRoutesConstant.postViewPage,
        builder: (context, state) => PostViewPage(
          imageUrl: state.pathParameters['imageUrl']!,
          name: state.pathParameters['name']!,
          profileImage: state.pathParameters['profileImage']!,
          dateTime: state.pathParameters['dateTime']!,
          caption: state.pathParameters['caption']!,
        ),
      ),
    ],
  );
}