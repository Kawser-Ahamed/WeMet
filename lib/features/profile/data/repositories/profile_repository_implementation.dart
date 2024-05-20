import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/features/profile/data/datasources/profile_datasource.dart';
import 'package:wemet/features/profile/data/model/profile_model.dart';
import 'package:wemet/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImplementation implements ProfileRepository{
  
  ProfileDatasource profileDatasource;
  ProfileRepositoryImplementation(this.profileDatasource);

  @override
  Future<Either<Failure, List<ProfileModel>>> getProfileData(String email) async{
    try{
      final response = await profileDatasource.getProfileData(email);
      return right(response);
    }
    catch(error){
      return left(Failure(error.toString()));
    }
  }
}