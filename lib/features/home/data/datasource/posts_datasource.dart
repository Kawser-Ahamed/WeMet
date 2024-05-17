import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:wemet/features/home/data/model/posts_model.dart';
import 'package:http/http.dart' as http;

abstract interface class PostsDatasource{
  Future<List<PostsModel>> getPosts(String url);
}

class PostsDatasourceImplementation implements PostsDatasource{
  @override
  Future<List<PostsModel>> getPosts(String url) async{
    List<PostsModel> postData = [];
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          postData.add(PostsModel.fromJson(values));
        }
        DateFormat formattedDate = DateFormat("d-MM-yyyy HH:mm");
        postData.sort((a,b){
          DateTime firstDate = formattedDate.parse(a.dateTime);
          DateTime secondDate = formattedDate.parse(b.dateTime);
          return secondDate.compareTo(firstDate);
        });
        return postData;
      }
      return postData;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }

}