import 'dart:convert';

import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/search/data/model/search_user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class SearchDataSource{

  Future<List<SearchUserModel>> getRandomUser();
  Future<List<SearchUserModel>> getSearchUser(String searchValue);

}

class SearchDataSourceImplementation implements SearchDataSource{

  @override
  Future<List<SearchUserModel>> getRandomUser() async{
    try{
      List<SearchUserModel> randomUser = [];
      var response = await http.get(Uri.parse(Serverurls.randomUser));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          randomUser.add(SearchUserModel.fromJson(values));
        }
      }
      return randomUser;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }
  
  @override
  Future<List<SearchUserModel>> getSearchUser(String searchValue) async{
    try{
      List<SearchUserModel> searchUser = [];
      var response = await http.get(Uri.parse('${Serverurls.searchUrl}/$searchValue'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          searchUser.add(SearchUserModel.fromJson(values));
        }
      }
      return searchUser;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }


}