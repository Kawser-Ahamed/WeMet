import 'dart:convert';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/following/data/model/following_data_model.dart';
import 'package:wemet/features/following/data/model/following_model.dart';
import 'package:http/http.dart' as http;

abstract interface class FollowingDatasource{

  Future<String> addFollowing(FollowingModel followingModel);
  Future<String> removeFollowing(FollowingModel followingModel);
  Future<Map<int,FollowingDataModel>> fetchFollowingData(String email);

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
  
  @override
  Future<Map<int,FollowingDataModel>> fetchFollowingData(String email) async{
    try{
      List<FollowingDataModel> followingData = [];
      Map<int,FollowingDataModel> followingUserMap = {}; 
      var response = await http.get(Uri.parse('${Serverurls.fetchFollowing}/$email'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var json in data){
          followingData.add(FollowingDataModel.fromJson(json));
        }
        for(int i=0;i<followingData.length;i++){
          followingUserMap[followingData[i].id] = followingData[i];
        }
      }
      return followingUserMap;
    }
    catch(error){
      throw Exception(error);
    }
  }
  
  @override
  Future<String> removeFollowing(FollowingModel followingModel) async{
    try{
      String json = jsonEncode(followingModel.toJosn());
      var response = await http.post(Uri.parse(Serverurls.removeFollowing),
        headers: <String,String> {
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