import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wemet/config/routes/app_routes.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const WeMet());
}

class WeMet extends StatelessWidget {
  const WeMet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    );
  }
}