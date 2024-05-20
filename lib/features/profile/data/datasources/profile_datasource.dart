import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/profile/data/model/profile_model.dart';
import 'package:http/http.dart' as http;

abstract interface class ProfileDatasource{
  Future<List<ProfileModel>> getProfileData(String email);
}

class ProfileDatasourceImplementation implements ProfileDatasource{
  
  @override
  Future<List<ProfileModel>> getProfileData(String email) async{
    try{
      List<ProfileModel> profileData = [];
      var response = await http.get(Uri.parse('${Serverurls.profileData}/$email'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          profileData.add(ProfileModel.fromJson(values));
        }
        DateFormat formattedTime = DateFormat("dd-MM-yyyy HH:mm");
        profileData.sort((a,b){
          DateTime firstDate = formattedTime.parse(a.dateTime);
          DateTime secondDdate = formattedTime.parse(b.dateTime);
          return secondDdate.compareTo(firstDate);
        });
        return profileData;
      }
      return profileData;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }
}