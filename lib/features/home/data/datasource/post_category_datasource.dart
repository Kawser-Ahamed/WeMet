import 'dart:convert';

import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/home/data/model/post_category_model.dart';
import 'package:http/http.dart' as http;

abstract interface class PostCategoryDatasource{
  Future<List<PostCategoryModel>> getPostCategory();
}

class PostCategoryDatasourceImplementation implements PostCategoryDatasource{
  
  @override
  Future<List<PostCategoryModel>> getPostCategory() async{
    List<PostCategoryModel> postCategoryData = [];
    try{
      var response = await http.get(Uri.parse(Serverurls.postCategoryUrl));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          postCategoryData.add(PostCategoryModel.fromJson(values));
        }
      }
      return postCategoryData;
    }
    catch(error){
      throw error.toString();
    }
  }

}