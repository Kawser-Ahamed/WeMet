import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/upload/data/model/upload_post_model.dart';
import 'package:http/http.dart' as http;

abstract interface class UploadPostDatasource{
  Future<String> uploadPost(UploadPostModel uploadPostModel);
  Future<String> uploadAttachmentImage({required File imageUrl});
}

class UploadPostDatasourceImplementation implements UploadPostDatasource{
  
  @override
  Future<String> uploadAttachmentImage({required File imageUrl}) async{
    try{
      Reference firebaseReference = FirebaseStorage.instance.ref('Images').child('attachment-${DateTime.now().microsecondsSinceEpoch}');
      UploadTask uploadTask = firebaseReference.putFile(imageUrl);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadImageUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadImageUrl;
    }
    catch(error){
      throw Exception(error.toString());
    }
  }

  @override
  Future<String> uploadPost(UploadPostModel uploadPostModel) async{
    try{
      String jsonData = jsonEncode(uploadPostModel.toJson());
      var response = await http.post(
        Uri.parse('${Serverurls.uploadPostUrl}/${uploadPostModel.email}'),
        headers: <String,String> {
          'Content-Type' : 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if(response.statusCode==200){
        return response.body.toString();
      }
      return "Error";
    }
    catch(error){
      return error.toString();
    }
  }
}