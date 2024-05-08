import 'dart:io';

import 'package:image_picker/image_picker.dart';

class WemetImagePicker{

  File ? imageFromDevice;
  String text = "Hello";

  Future<void> pickImageFromGallery() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;
    imageFromDevice = File(image.path);
    text = "success";
  }
  
  Future<void> pickImageFromCamera() async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if(image==null) return;
    imageFromDevice = File(image.path);
    text = "success";
  }
}