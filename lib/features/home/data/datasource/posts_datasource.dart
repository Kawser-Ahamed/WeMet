import 'dart:convert';

import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/home/data/model/posts_model.dart';
import 'package:http/http.dart' as http;

abstract interface class PostsDatasource{
  Future<List<PostsModel>> getPosts();
}

class PostsDatasourceImplementation implements PostsDatasource{
  @override
  Future<List<PostsModel>> getPosts() async{
    List<PostsModel> allPostData = [];
    try{
      var response = await http.get(Uri.parse(Serverurls.allPostUrl));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          allPostData.add(PostsModel.fromJson(values));
        }
        return allPostData;
      }
      return allPostData;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }

}