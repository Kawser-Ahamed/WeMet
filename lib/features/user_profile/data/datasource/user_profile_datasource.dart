import 'package:wemet/features/user_profile/data/model/user_profile_data_model.dart';
import 'package:wemet/features/user_profile/data/model/user_profile_post_model.dart';

abstract interface class UserProfileDatasource{

  Future<List<UserProfileDataModel>> getUserProfileData();
  Future<List<UserProfilePostModel>> getUserProfilePost();

}

class UserProfileDatasourceImplementation implements UserProfileDatasource{

  @override
  Future<List<UserProfileDataModel>> getUserProfileData() {
    throw UnimplementedError();
  }

  @override
  Future<List<UserProfilePostModel>> getUserProfilePost() {
    throw UnimplementedError();
  }

}