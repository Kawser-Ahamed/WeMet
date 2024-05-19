import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/auth/domain/entities/user_entities.dart';
import 'package:wemet/features/auth/domain/repositories/auth_repository.dart';

class UserUsecase implements UseCase<List<UserEntities>,UserEmailParams>{
  
  AuthRepository authRepository;
  UserUsecase(this.authRepository);

  @override
  Future<Either<Failure, List<UserEntities>>> call(UserEmailParams params) async{
    return await authRepository.getUserData(params.email);
  }
}

class UserEmailParams{

  final String email;
  UserEmailParams({required this.email});
}