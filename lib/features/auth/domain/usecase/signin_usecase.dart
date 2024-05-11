import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';
import 'package:wemet/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase implements UseCase<List<UserEntities>,SignInParams>{

  final AuthRepository authRepository;
  SignInUseCase(this.authRepository);

  @override
  Future<Either<Failure, List<UserEntities>>> call(SignInParams params) async{
    return await authRepository.signInWithEmailAndPassword(email: params.email, password: params.password);
  }
}

class SignInParams{
  final String email;
  final String password;
  SignInParams({required this.email,required this.password});
}