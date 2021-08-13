import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _storedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _storedImage = File(imageFile.path);
    });
    widget.imagePickFn(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              _storedImage != null ? FileImage(_storedImage) : null,
          radius: 60,
        ),
        ElevatedButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image_outlined),
            label: Text('Add')),
      ],
    );
  }
}
