import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? takenPic;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      takenPic = File(pickedImage.path);
    });
    widget.onPickImage(takenPic!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      label: Text('Take Picture'),
      icon: Icon(Icons.camera),
    );

    if (takenPic != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          takenPic!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.white)),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
