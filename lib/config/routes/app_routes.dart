import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
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
    ],
  );
}