import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wemet/core/urls/server_urls.dart';
import 'package:wemet/features/edit_profile/data/model/edit_profile_mdoel.dart';
import 'package:http/http.dart' as http;

abstract interface class EditProfileDataSource{
  Future<String> updateProfile(EditprofileModel editprofileModel);
   Future<String> updateProfilePicture(File profilePicture,String email);
  Future<String> updateCoverphoto(File coverPhoto,String email);
}

class EditProfileDataSourceImplementation implements EditProfileDataSource{
  @override
  Future<String> updateProfile(EditprofileModel editprofileModel) async{
    try{
      var json = jsonEncode(editprofileModel.toJson());
      var response = await http.put(Uri.parse('${Serverurls.updateProfile}/${editprofileModel.email}'),
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
  Future<String> updateProfilePicture(File profilePicture,String email) async{
    try{
      Reference reference = FirebaseStorage.instance.ref("Images").child('Profile Picture-${DateTime.now().microsecondsSinceEpoch}.png');
      UploadTask uploadTask = reference.putFile(profilePicture);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      Map<String,String> json = {
        'profileImageUrl' : downloadUrl,
      };
      String jsonData = jsonEncode(json);
      var response = await http.put(Uri.parse('${Serverurls.updateProfilePicture}/$email'),
        headers: <String,String> {
          'Content-Type' : 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if(response.statusCode == 200){
        return response.body.toString();
      }
      return 'Server Error.';
    }
    catch(error){
      throw Exception(error);
    }
  }

  @override
  Future<String> updateCoverphoto(File coverPhoto,String email) async{
    try{
      Reference reference = FirebaseStorage.instance.ref("Images").child('Cover Photo-${DateTime.now().microsecondsSinceEpoch}.png');
      UploadTask uploadTask = reference.putFile(coverPhoto);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      Map<String,String> json = {
        'coverPhotoUrl' : downloadUrl,
      };
      String jsonData = jsonEncode(json);
      var response = await http.put(Uri.parse('${Serverurls.updateCoverPhoto}/$email'),
        headers: <String,String> {
          'Content-Type' : 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if(response.statusCode == 200){
        return response.body.toString();
      }
      return 'Server Error.';
    }
    catch(error){
      throw Exception(error);
    }
  }
  
  
}