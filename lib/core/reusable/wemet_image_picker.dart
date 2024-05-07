import 'dart:io';

import 'package:image_picker/image_picker.dart';

class WemetImagePicker{

  File ? imageFromGallery;
  File ? imageFromCamera;
  String text = "Hello";

  Future<void> pickImageFromGallery() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;
    imageFromGallery = File(image.path);
    text = "success";
  }
  
  Future<void> pickImageFromCamera() async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if(image==null) return;
    imageFromCamera = File(image.path);
    text = "success";
  }
}