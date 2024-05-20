import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/user_profile/data/model/user_profile_data_model.dart';
import 'package:wemet/features/user_profile/data/model/user_profile_post_model.dart';
import 'package:http/http.dart' as http;

abstract interface class UserProfileDatasource{

  Future<List<UserProfileDataModel>> getUserProfileData(String email);
  Future<List<UserProfilePostModel>> getUserProfilePost(String email);

}

class UserProfileDatasourceImplementation implements UserProfileDatasource{

  @override
  Future<List<UserProfileDataModel>> getUserProfileData(String email) async{
    // try{
    //   List<UserProfileDataModel> userProfileData = [];
    //   QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(email).get();
    //   for(var values in querySnapshot.docs){
    //     userProfileData.add(UserProfileDataModel.fromJson(values.data()));
    //   }
    //   return userProfileData;
    // }
    // catch(error){
    //   throw Exception(error);
    // }
    try{
      List<UserProfileDataModel> userData = [];
      var response = await http.get(Uri.parse('${Serverurls.userData}/$email'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          userData.add(UserProfileDataModel.fromJson(values));
        }
      } 
      return userData;
    }
    catch(error){
      throw Exception(error);
    }
  }

  @override
  Future<List<UserProfilePostModel>> getUserProfilePost(String email) async{
    try{
      List<UserProfilePostModel> userProfilePost = [];
      var response = await http.get(Uri.parse('${Serverurls.profileData}/$email'));
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          userProfilePost.add(UserProfilePostModel.fromJson(values));
        }
        DateFormat formattedTime = DateFormat("dd-MM-yyyy HH:mm");
        userProfilePost.sort((a,b){
          DateTime firstDate = formattedTime.parse(a.dateTime);
          DateTime secondDate = formattedTime.parse(b.dateTime);
          return secondDate.compareTo(firstDate);
        });
        return userProfilePost;
      }
      return userProfilePost;
    }
    catch(error){
      throw Exception(error);
    }
  }

}