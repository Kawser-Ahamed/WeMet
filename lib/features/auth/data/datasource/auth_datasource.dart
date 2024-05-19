import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wemet/features/auth/data/model/user_model.dart';

abstract interface class AuthDatasource{

  Future<UserModel> signUpWithEmailAndPassword(UserModel userModel);
  Future<List<UserModel>> signInWithEmailAndPassword(String email,String password);
  Future<String> uploadProfilePicture(File profilePictureFromDevice);
  Future<String> uploadCoverPhoto(File coverPhotoFromDevice);
  Future<List<UserModel>> getUserData(String email);
}

class AuthDatasourceImplementation implements AuthDatasource{
  @override
  Future<UserModel> signUpWithEmailAndPassword(UserModel userModel) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email, 
        password: userModel.password
      ).then((value){
        FirebaseFirestore.instance.collection(userModel.email).doc('Profile').set(userModel.toJson());
      });
      return userModel;
    } on FirebaseAuthException catch(e){
      if(e.code == 'invalid-email'){
        throw 'Invalid Email Address.';
      }
      else if(e.code == 'weak-password'){
        throw 'weak-password.';
      }
      else if(e.code == 'email-already-in-use'){
        throw 'This email is already used by another account.';
      }
    } on TimeoutException{
      throw 'Time out.Please Check your internet connection and try again.';
    }
    catch(error){
      throw error.toString();
    }
    throw 'Something Went Wrong.';
  }

  @override
  Future<String> uploadProfilePicture(File profilePictureFromDevice)  async{
    try{
      Reference firebaseStorageReference = FirebaseStorage.instance.ref('Images').child('Profile Picture${DateTime.now().microsecondsSinceEpoch.toString()}.png'); 
      UploadTask  uploadTask =  firebaseStorageReference.putFile(profilePictureFromDevice);
      TaskSnapshot taskSnapshot = await uploadTask;
      String profilePictureImageUrl= await taskSnapshot.ref.getDownloadURL();
      return profilePictureImageUrl;
    } 
    catch(error){
      throw Exception(error.toString());
    }
  }
  
  @override
  Future<String> uploadCoverPhoto(File coverPhotoFromDevice) async{
     try{
      Reference firebaseStorageReference = FirebaseStorage.instance.ref('Images').child('Cover Photo${DateTime.now().microsecondsSinceEpoch.toString()}.png'); 
      UploadTask  uploadTask =  firebaseStorageReference.putFile(coverPhotoFromDevice);
      TaskSnapshot taskSnapshot = await uploadTask;
      String coverPhotoimageurl= await taskSnapshot.ref.getDownloadURL();
      return coverPhotoimageurl;
     }
     catch(error){
      throw Exception(error.toString());
     }
  }
  
  @override
  Future<List<UserModel>> signInWithEmailAndPassword(String email, String password)async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      )
      .then((value) => null);
      return getUser(email);
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        throw 'No account found with this email';
      }
      else if(e.code == 'wrong-password'){
        throw 'Incorrect Password';
      }
      else{
        throw 'Email or Password is incorrect.Please try again';
      }
    }
    catch(error){
      throw error.toString();
    }
  }

  Future<List<UserModel>> getUser(String email) async{
    try{
      List<UserModel> userData = [];
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(email).get();
      for (var values in querySnapshot.docs) {
        userData.add(UserModel.fromJson(values.data()));
      }
      return userData;
    }
    catch(error){
      throw error.toString();
    }
  }
  
  @override
  Future<List<UserModel>> getUserData(String email) async{
    try{
      List<UserModel> userData = [];
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(email).get();
      for(var values in querySnapshot.docs){
        userData.add(UserModel.fromJson(values.data()));
      }
      return userData;
    }
    catch(error){
      throw Exception(error);
    }
  }
}