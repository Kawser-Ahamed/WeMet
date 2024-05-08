import 'package:wemet/features/auth/data/model/user_model.dart';

abstract interface class AuthDatasource{

  Future<UserModel> signUpWithEmailAndPassword(UserModel userModel);

}

class AuthDatasourceImplementation implements AuthDatasource{
  @override
  Future<UserModel> signUpWithEmailAndPassword(UserModel userModel) async {
    try{
      print(userModel.email);
      return userModel;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }


}