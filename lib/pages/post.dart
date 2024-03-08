import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

// ignore: camel_case_types
class posts extends StatefulWidget {
  const posts({super.key});

  @override
  _postsState createState() => _postsState();
}

// ignore: camel_case_types
class _postsState extends State<posts> {
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Upload"),
          content: Text("Do you want to upload this image?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  String pid = Uuid().v4();
                  FirebaseStorage storage = FirebaseStorage.instance;
                  var snapshot = await storage
                      .ref('post')
                      .child('$pid.jpg')
                      .putFile(_imageFile!);
                  String downloadUrl = await snapshot.ref.getDownloadURL();

                  // Here you can store the downloadUrl into your database.
                  // For example, you can use Firebase Firestore or Realtime Database.

                  print(
                      'File uploaded successfully. Download URL: $downloadUrl');
                } catch (e) {
                  print('Error uploading file: $e');
                }
              },
              child: Text("Upload"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: _imageFile == null
            ? Text('No image selected.')
            : Image.network(_imageFile!.path), // Use Image.network for web
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.image),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _uploadImage,
            tooltip: 'Upload Image',
            child: Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }
}
