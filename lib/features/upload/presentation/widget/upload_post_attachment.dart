import 'package:flutter/material.dart';
import 'package:wemet/core/responsive/screen.dart';
import 'package:wemet/core/reusable/wemet_image_picker.dart';
import 'package:wemet/core/urls/app_image_urls.dart';

class UploadPostAttachment extends StatefulWidget {
  final WemetImagePicker wemetImagePicker;
  const UploadPostAttachment({super.key, required this.wemetImagePicker});

  @override
  State<UploadPostAttachment> createState() => _UploadPostAttachmentState();
}

class _UploadPostAttachmentState extends State<UploadPostAttachment> {
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return  Container(
      height: height * 0.2,
      width: width * 1,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade600,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: FittedBox(
                      child: InkWell(
                        onTap: (){
                          widget.wemetImagePicker.pickImageFromCamera().whenComplete((){
                            setState(() {});
                          });    
                        },
                        child: const Icon(Icons.camera_enhance,color: Colors.blue)
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: FittedBox(
                      child: InkWell(
                        onTap: (){
                          widget.wemetImagePicker.pickImageFromGallery().whenComplete((){
                            setState(() {});
                          });
                        },
                        child: const Icon(Icons.image,color: Colors.green)
                      ),
                    ),
                  )
                ),
              ],
            )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.01),
              child: (widget.wemetImagePicker.imageFromDevice == null) ? Image.asset(AppImageUrls.imageIcon) : Image.file(widget.wemetImagePicker.imageFromDevice!),
            ),
          ),
        ],
      ),
    );
  }
}