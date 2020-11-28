import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreen createState() => _AlbumScreen();
}

class _AlbumScreen extends State<AlbumScreen> {
  File image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Connect'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          child: image == null ? Text('No Image Showing') : Image.file(image),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add_a_photo),
        onPressed: getImage,
      ),
    );
  }
}
