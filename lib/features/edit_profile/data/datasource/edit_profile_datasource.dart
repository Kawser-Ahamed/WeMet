import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wemet/features/edit_profile/data/model/edit_profile_mdoel.dart';

abstract interface class EditProfileDataSource{
  Future<String> updateProfile(EditprofileModel editprofileModel);
   Future<String> updateprofilePicture(File profilePicture,String email);
  Future<String> updateCoverphoto(File coverPhoto,String email);
}

class EditProfileDataSourceImplementation implements EditProfileDataSource{
  @override
  Future<String> updateProfile(EditprofileModel editprofileModel) async{
    try{
      FirebaseFirestore.instance.collection(editprofileModel.email).doc('Profile').update(editprofileModel.toJson());
      return 'You updated your profile successfully';
    }
    catch(error){
      throw Exception(error);
    }
  }
  
  @override
  Future<String> updateprofilePicture(File profilePicture,String email) async{
    try{
      Reference reference = FirebaseStorage.instance.ref("Images").child('Profile Picture-${DateTime.now().microsecondsSinceEpoch}.png');
      UploadTask uploadTask = reference.putFile(profilePicture);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection(email).doc('Profile').update({
        'profileImageUrl' : downloadUrl,
      });
      return 'Your profile picture has been changed';
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
      FirebaseFirestore.instance.collection(email).doc('Profile').update({
        'coverPhotoUrl' : downloadUrl,
      });
      return 'Your cover photo has been changed';
    }
    catch(error){
      throw Exception(error);
    }
  }
  
  
}