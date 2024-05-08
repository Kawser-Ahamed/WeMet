import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/config/routes/app_routes.dart';
import 'package:wemet/features/auth/data/datasource/auth_datasource.dart';
import 'package:wemet/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:wemet/features/auth/domain/usecase/auth_usecase.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
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
        BlocProvider(create: (context)=>
          AuthBloc(
            authUseCase: AuthUseCase(
              AuthRepositoryImplementation(
                AuthDatasourceImplementation(),
              ),
            )
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}