import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/edit_profile/domain/entities/edit_profile_entities.dart';
import 'package:wemet/features/edit_profile/domain/repositories/edit_profile_repository.dart';

class EditProfileUsecase implements UseCase<String,EditProfileEntities>{
  
  EditProfileRepository editProfileRepository;
  EditProfileUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, String>> call(EditProfileEntities editProfileEntities) async{
    return await editProfileRepository.updateProfile(editProfileEntities);
  }

}