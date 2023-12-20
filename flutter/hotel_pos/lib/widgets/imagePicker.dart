import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(List<File?>) onImagesSelected;

  const CustomImagePicker({super.key, required this.onImagesSelected});
  @override
  State<CustomImagePicker> createState()  => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  List <File?> _image = [];
  final picker = ImagePicker();

 @override
  void initState() {
    super.initState();
    //_image = [null]; // Initialize with a default image
  }

  //Image Picker function to get imu64age from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      }
    });
    widget.onImagesSelected(_image);
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      }
    });
    widget.onImagesSelected(_image);
  }
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextButton(
            child: Text('Select Image'),
            onPressed: showOptions,
          ),
          Expanded(
            child: GridView.builder(
              //section to define column number, x andy spacing  
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5.0, //x spacing
                mainAxisSpacing: 5.0,  //y spacing
              ),
              itemCount: _image.length,
              itemBuilder: (context, index) {
                  //put your item rendering here
                  return Image.file(_image[index]!);
                  //return null;
              },
            ),
          ),
        ],
      ),
    );
  }

}