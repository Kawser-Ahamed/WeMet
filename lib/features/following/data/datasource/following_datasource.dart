import 'dart:convert';

import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/following/data/model/following_model.dart';
import 'package:http/http.dart' as http;

abstract interface class FollowingDatasource{

  Future<String> addFollowing(FollowingModel followingModel);

}

class FollowingDatasourceImplementation implements FollowingDatasource{
  
  @override
  Future<String> addFollowing(FollowingModel followingModel) async{
    try{
      String json = jsonEncode(followingModel.toJosn());
      var response = await http.post(Uri.parse(Serverurls.addFollowing),
        headers: <String,String>{
          'Content-Type' : 'application/json; charset=UTF-8',
        },
        body: json,
      );
      if(response.statusCode == 200){ 
        return response.body.toString();
      }
      return 'Server Error';
    }
    catch(error){
      throw Exception(error);
    }
  }

}