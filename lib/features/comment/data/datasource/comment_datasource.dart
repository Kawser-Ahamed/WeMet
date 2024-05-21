import 'dart:convert';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/comment/data/model/comment_model.dart';
import 'package:http/http.dart' as http;

abstract interface class CommentDataSource{

  Future<List<CommentModel>> fetchComment(int id);
  Future<String> uploadComment(CommentModel commentModel);

}

class CommentDatasourceImplementation implements CommentDataSource{
  @override
  Future<List<CommentModel>> fetchComment(int id) async{
    try{
      List<CommentModel> commentData = [];
      var response = await http.get(Uri.parse('${Serverurls.fetchComment}/${id.toString()}'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        for(var values in data){
          commentData.add(CommentModel.fromJson(values));
        }
        return commentData;
      }
      return commentData;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }

  @override
  Future<String> uploadComment(CommentModel commentModel) async{
    try{
      String json = jsonEncode(commentModel.toJson());
      var response = await http.post(
        Uri.parse(
          '${Serverurls.uploadComment}/${commentModel.id}'
        ),
        headers: <String,String>{
          'content-type' : 'application/json; charset=UTF-8',
        },
        body: json,
      );
      if(response.statusCode == 200){
        return response.body.toString();
      }
      return response.body.toString();
    }
    catch(error){
      throw Exception(error.toString());
    }
  }
}