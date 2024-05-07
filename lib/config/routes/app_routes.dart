import 'package:go_router/go_router.dart';
import 'package:wemet/config/routes/app_routes_constant.dart';
import 'package:wemet/features/auth/presentation/pages/sign_in.dart';
import 'package:wemet/features/auth/presentation/pages/sign_up.dart';

class AppRoutes{
  static final GoRouter router = GoRouter(
    routes:[
      GoRoute(
        path: '/',
        name: AppRoutesConstant.signIn,
        builder: (context, state) {
          return const SignIn();
        },
      ),
      GoRoute(
        path: '/signUp',
        name: AppRoutesConstant.signUp,
        builder: (context, state) {
          return const SignUp();
        },
      ),
    ],
  );
}